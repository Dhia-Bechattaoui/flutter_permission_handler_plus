import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_permission_handler_plus/src/permission_config.dart';
import 'package:flutter_permission_handler_plus/src/permission_status.dart';
import 'package:flutter_permission_handler_plus/src/permission_type.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Web implementation of the permission handler.
class FlutterPermissionHandlerPlusWeb {
  static void registerWith(final Registrar registrar) {
    final channel = MethodChannel(
      'flutter_permission_handler_plus',
      const StandardMethodCodec(),
      registrar,
    );
    final instance = FlutterPermissionHandlerPlusWeb();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<PermissionStatus> requestPermission(
    final PermissionType permissionType, {
    final PermissionConfig? config,
  }) async {
    // On Web, we can't request native permissions
    // Return granted status as a fallback
    return PermissionStatus.granted;
  }

  Future<Map<PermissionType, PermissionStatus>> requestPermissions(
    final Map<PermissionType, PermissionConfig> permissions,
  ) async {
    final results = <PermissionType, PermissionStatus>{};
    for (final permission in permissions.keys) {
      results[permission] = await requestPermission(
        permission,
        config: permissions[permission],
      );
    }
    return results;
  }

  Future<PermissionStatus> checkPermissionStatus(
    final PermissionType permissionType,
  ) async {
    // On Web, we can't check native permission status
    // Return granted status as a fallback
    return PermissionStatus.granted;
  }

  Future<Map<PermissionType, PermissionStatus>> checkPermissionStatuses(
    final List<PermissionType> permissionTypes,
  ) async {
    final results = <PermissionType, PermissionStatus>{};
    for (final permission in permissionTypes) {
      results[permission] = await checkPermissionStatus(permission);
    }
    return results;
  }

  Future<bool> openAppSettings() async {
    // On Web, we can't open app settings
    return false;
  }

  Future<bool> isPermanentlyDenied(final PermissionType permissionType) async {
    // On Web, permissions are not permanently denied
    return false;
  }

  Future<bool> shouldShowRequestPermissionRationale(
    final PermissionType permissionType,
  ) async {
    // On Web, we don't need to show rationale
    return false;
  }

  Future<dynamic> handleMethodCall(final MethodCall call) async {
    final args = (call.arguments as Map<Object?, Object?>?) ?? const {};

    switch (call.method) {
      case 'requestPermission':
        final permissionName = args['permission'] as String? ?? '';
        final permissionType = PermissionType.values.firstWhere(
          (final e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        final result = await requestPermission(permissionType);
        return result.index;
      case 'checkPermissionStatus':
        final permissionName = args['permission'] as String? ?? '';
        final permissionType = PermissionType.values.firstWhere(
          (final e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        final result = await checkPermissionStatus(permissionType);
        return result.index;
      case 'shouldShowRequestPermissionRationale':
        final permissionName = args['permission'] as String? ?? '';
        final permissionType = PermissionType.values.firstWhere(
          (final e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        return shouldShowRequestPermissionRationale(permissionType);
      case 'openAppSettings':
        return openAppSettings();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              "flutter_permission_handler_plus for web doesn't implement '${call.method}'",
        );
    }
  }
}
