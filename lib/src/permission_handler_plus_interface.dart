import 'permission_config.dart';
import 'permission_status.dart';
import 'permission_type.dart';

/// Interface for the permission handler across all platforms.
///
/// This interface ensures consistent behavior across different platforms
/// while allowing platform-specific implementations.
abstract class PermissionHandlerPlusInterface {
  /// Requests a single permission with enhanced UX features.
  ///
  /// [permissionType] The type of permission to request.
  /// [config] Optional configuration for customizing the request flow.
  ///
  /// Returns a [Future] that completes with the final [PermissionStatus].
  ///
  /// Throws [PermissionRequestException] if the request fails.
  /// Throws [UnsupportedPermissionException] if the permission is not supported.
  Future<PermissionStatus> requestPermission(
    PermissionType permissionType, {
    PermissionConfig config,
  });

  /// Requests multiple permissions simultaneously.
  ///
  /// [permissions] A map of permission types to their configurations.
  ///
  /// Returns a [Future] that completes with a map of permission statuses.
  Future<Map<PermissionType, PermissionStatus>> requestPermissions(
    Map<PermissionType, PermissionConfig> permissions,
  );

  /// Checks the current status of a permission.
  ///
  /// [permissionType] The type of permission to check.
  ///
  /// Returns a [Future] that completes with the current [PermissionStatus].
  Future<PermissionStatus> checkPermissionStatus(PermissionType permissionType);

  /// Checks the current status of multiple permissions.
  ///
  /// [permissionTypes] A list of permission types to check.
  ///
  /// Returns a [Future] that completes with a map of permission statuses.
  Future<Map<PermissionType, PermissionStatus>> checkPermissionStatuses(
    List<PermissionType> permissionTypes,
  );

  /// Opens the app settings page.
  ///
  /// This is useful when permissions are permanently denied and the user
  /// needs to manually enable them in the system settings.
  ///
  /// Returns a [Future] that completes when the settings page is opened.
  Future<bool> openAppSettings();

  /// Checks if a permission is permanently denied.
  ///
  /// [permissionType] The type of permission to check.
  ///
  /// Returns a [Future] that completes with true if permanently denied.
  Future<bool> isPermanentlyDenied(PermissionType permissionType);

  /// Checks if a permission should show a rationale.
  ///
  /// [permissionType] The type of permission to check.
  ///
  /// Returns a [Future] that completes with true if rationale should be shown.
  Future<bool> shouldShowRequestPermissionRationale(
      PermissionType permissionType);
}
