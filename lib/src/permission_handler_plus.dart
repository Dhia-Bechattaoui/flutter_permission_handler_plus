import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Conditional imports for platform-specific functionality
import 'exceptions.dart';
import 'permission_config.dart';
import 'permission_handler_plus_interface.dart';
import 'permission_status.dart';
import 'permission_type.dart';
import 'platform_detector.dart';

/// The main permission handler class providing improved UX and automatic permission requests.
///
/// This class provides a simplified API for handling permissions with enhanced user experience
/// features including automatic rationale dialogs, smart retry mechanisms, and seamless
/// settings integration.
class PermissionHandlerPlus implements PermissionHandlerPlusInterface {
  /// Private constructor for singleton pattern.
  PermissionHandlerPlus._();

  /// Factory constructor that returns the singleton instance.
  factory PermissionHandlerPlus() {
    _instance ??= PermissionHandlerPlus._();
    return _instance!;
  }

  /// The method channel used to communicate with platform-specific code.
  static const MethodChannel _channel =
      MethodChannel('flutter_permission_handler_plus');

  /// Cache for permission statuses to avoid unnecessary platform calls.
  static final Map<PermissionType, PermissionStatus> _statusCache = {};

  /// Cache for pending permission requests to avoid duplicate requests.
  static final Map<PermissionType, Completer<PermissionStatus>>
      _pendingRequests = {};

  /// Singleton instance of the permission handler.
  static PermissionHandlerPlus? _instance;

  /// Gets the singleton instance of [PermissionHandlerPlus].
  static PermissionHandlerPlus get instance {
    _instance ??= PermissionHandlerPlus._();
    return _instance!;
  }

  /// Requests a single permission with enhanced UX features.
  ///
  /// This method handles the complete permission request flow including:
  /// - Checking current permission status
  /// - Showing rationale dialog if needed
  /// - Requesting the actual permission
  /// - Handling denials with retry logic
  /// - Redirecting to settings for permanently denied permissions
  ///
  /// [permissionType] The type of permission to request.
  /// [config] Optional configuration for customizing the request flow.
  ///
  /// Returns a [Future] that completes with the final [PermissionStatus].
  ///
  /// Throws [PermissionRequestException] if the request fails.
  /// Throws [UnsupportedPermissionException] if the permission is not supported.
  @override
  Future<PermissionStatus> requestPermission(
    PermissionType permissionType, {
    PermissionConfig config = const PermissionConfig(),
  }) async {
    try {
      // Check if there's already a pending request for this permission
      if (_pendingRequests.containsKey(permissionType)) {
        return await _pendingRequests[permissionType]!.future;
      }

      final completer = Completer<PermissionStatus>();
      _pendingRequests[permissionType] = completer;

      try {
        final status = await _requestPermissionInternal(permissionType, config);
        completer.complete(status);
        return status;
      } catch (e) {
        completer.completeError(e);
        rethrow;
      } finally {
        _pendingRequests.remove(permissionType);
      }
    } on PlatformException catch (e) {
      throw PermissionRequestException('Platform error: ${e.message}');
    } catch (e) {
      throw PermissionRequestException('Unexpected error: $e');
    }
  }

  /// Requests multiple permissions simultaneously.
  ///
  /// This is more efficient than requesting permissions one by one and provides
  /// a better user experience by batching related permission requests.
  ///
  /// [permissions] A map of permission types to their configurations.
  ///
  /// Returns a [Future] that completes with a map of permission statuses.
  @override
  Future<Map<PermissionType, PermissionStatus>> requestPermissions(
    Map<PermissionType, PermissionConfig> permissions,
  ) async {
    final results = <PermissionType, PermissionStatus>{};

    // Process permissions in parallel for better performance
    final futures = permissions.entries.map((entry) async {
      final status = await requestPermission(entry.key, config: entry.value);
      return MapEntry(entry.key, status);
    });

    final entries = await Future.wait(futures);

    for (final entry in entries) {
      results[entry.key] = entry.value;
    }

    return results;
  }

  /// Checks the current status of a permission without requesting it.
  ///
  /// This method returns the cached status if available, otherwise queries
  /// the platform for the current status.
  ///
  /// [permissionType] The type of permission to check.
  /// [useCache] Whether to use cached status. Defaults to true.
  ///
  /// Returns a [Future] that completes with the current [PermissionStatus].
  @override
  Future<PermissionStatus> checkPermissionStatus(
    PermissionType permissionType, {
    bool useCache = true,
  }) async {
    // Return cached status if available and cache is enabled
    if (useCache && _statusCache.containsKey(permissionType)) {
      return _statusCache[permissionType]!;
    }

    try {
      final result = await _channel.invokeMethod<int>(
        'checkPermissionStatus',
        {'permission': permissionType.name},
      );

      final status = _intToPermissionStatus(result);
      _statusCache[permissionType] = status;
      return status;
    } on PlatformException catch (e) {
      if (e.code == 'UNSUPPORTED_PERMISSION') {
        return PermissionStatus.notApplicable;
      }
      throw PermissionRequestException(
          'Failed to check permission status: ${e.message}');
    }
  }

  /// Checks the status of multiple permissions.
  ///
  /// [permissionTypes] List of permission types to check.
  /// [useCache] Whether to use cached statuses. Defaults to true.
  ///
  /// Returns a [Future] that completes with a map of permission statuses.
  @override
  Future<Map<PermissionType, PermissionStatus>> checkPermissionStatuses(
    List<PermissionType> permissionTypes, {
    bool useCache = true,
  }) async {
    final results = <PermissionType, PermissionStatus>{};

    // Process status checks in parallel
    final futures = permissionTypes.map((type) async {
      final status = await checkPermissionStatus(type, useCache: useCache);
      return MapEntry(type, status);
    });

    final entries = await Future.wait(futures);

    for (final entry in entries) {
      results[entry.key] = entry.value;
    }

    return results;
  }

  /// Opens the app settings page where users can manually enable permissions.
  ///
  /// This is typically called when a permission is permanently denied and
  /// the only way to enable it is through the system settings.
  ///
  /// Returns a [Future] that completes with true if settings were opened successfully.
  @override
  Future<bool> openAppSettings() async {
    try {
      final result = await _channel.invokeMethod<bool>('openAppSettings');
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to open app settings: ${e.message}');
      }
      return false;
    }
  }

  /// Clears the permission status cache.
  ///
  /// This forces the next permission status check to query the platform
  /// instead of using cached values.
  void clearCache() {
    _statusCache.clear();
  }

  /// Checks if a permission should show rationale on the current platform.
  ///
  /// This is particularly useful on Android where the system provides
  /// information about whether to show rationale to the user.
  ///
  /// [permissionType] The type of permission to check.
  ///
  /// Returns a [Future] that completes with true if rationale should be shown.
  @override
  Future<bool> shouldShowRequestPermissionRationale(
    PermissionType permissionType,
  ) async {
    // On iOS, we always show rationale for denied permissions
    if (PlatformDetector.isIOS) {
      final status = await checkPermissionStatus(permissionType);
      return status.shouldShowRationale;
    }

    try {
      final result = await _channel.invokeMethod<bool>(
        'shouldShowRequestPermissionRationale',
        {'permission': permissionType.name},
      );
      return result ?? false;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to check rationale status: ${e.message}');
      }
      return false;
    }
  }

  /// Internal method to handle the actual permission request flow.
  Future<PermissionStatus> _requestPermissionInternal(
    PermissionType permissionType,
    PermissionConfig config,
  ) async {
    // First check current status
    var status = await checkPermissionStatus(permissionType, useCache: false);

    // If already granted, return immediately
    if (status.isGranted) {
      return status;
    }

    // If not applicable, return immediately
    if (status.isNotApplicable) {
      return status;
    }

    // If permanently denied and settings redirect is enabled, handle accordingly
    if (status.isPermanentlyDenied && config.enableSettingsRedirect) {
      await _handlePermanentlyDenied(permissionType, config);
      // Re-check status after potential settings visit
      return checkPermissionStatus(permissionType, useCache: false);
    }

    // Show rationale if needed and enabled
    if (config.enableAutoRationale && status.shouldShowRationale) {
      final shouldProceed = await _showRationale(permissionType, config);
      if (!shouldProceed) {
        return status;
      }
    }

    // Request the permission with retry logic
    int attempts = 0;
    while (attempts <= config.retryCount) {
      try {
        final result = await _channel.invokeMethod<int>(
          'requestPermission',
          {'permission': permissionType.name},
        );

        status = _intToPermissionStatus(result);
        _statusCache[permissionType] = status;

        // If granted or permanently denied, we're done
        if (status.isGranted || status.isPermanentlyDenied) {
          break;
        }

        attempts++;

        // If we have more attempts and permission was denied, show rationale again
        if (attempts <= config.retryCount &&
            status.isDenied &&
            config.enableAutoRationale) {
          final shouldRetry = await _showRetryRationale(permissionType, config);
          if (!shouldRetry) {
            break;
          }
        }
      } on PlatformException catch (e) {
        if (e.code == 'UNSUPPORTED_PERMISSION') {
          throw UnsupportedPermissionException(
            'Permission ${permissionType.name} is not supported on this platform',
          );
        }
        throw PermissionRequestException('Platform error: ${e.message}');
      }
    }

    return status;
  }

  /// Shows rationale dialog to the user explaining why the permission is needed.
  Future<bool> _showRationale(
    PermissionType permissionType,
    PermissionConfig config,
  ) async {
    // This would typically show a platform-specific dialog
    // For now, we'll just return true to proceed with the request
    // In a real implementation, this would show a native dialog or Flutter dialog
    return true;
  }

  /// Shows retry rationale dialog when permission was denied.
  Future<bool> _showRetryRationale(
    PermissionType permissionType,
    PermissionConfig config,
  ) async {
    // Similar to _showRationale but with retry-specific messaging
    return true;
  }

  /// Handles permanently denied permissions by offering to open settings.
  Future<void> _handlePermanentlyDenied(
    PermissionType permissionType,
    PermissionConfig config,
  ) async {
    // This would show a dialog explaining that the user needs to enable
    // the permission in settings and offer to open the settings page
    // For now, we'll just open settings directly
    await openAppSettings();
  }

  /// Checks if a permission is permanently denied.
  ///
  /// [permissionType] The type of permission to check.
  ///
  /// Returns a [Future] that completes with true if permanently denied.
  @override
  Future<bool> isPermanentlyDenied(PermissionType permissionType) async {
    final status = await checkPermissionStatus(permissionType);
    return status.isPermanentlyDenied;
  }

  /// Converts an integer result from the platform to a [PermissionStatus].
  PermissionStatus _intToPermissionStatus(int? result) {
    switch (result) {
      case 0:
        return PermissionStatus.undetermined;
      case 1:
        return PermissionStatus.granted;
      case 2:
        return PermissionStatus.denied;
      case 3:
        return PermissionStatus.permanentlyDenied;
      case 4:
        return PermissionStatus.restricted;
      case 5:
        return PermissionStatus.notApplicable;
      default:
        return PermissionStatus.undetermined;
    }
  }
}
