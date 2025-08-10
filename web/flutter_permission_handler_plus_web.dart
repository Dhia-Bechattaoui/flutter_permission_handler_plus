import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:flutter_permission_handler_plus/src/permission_config.dart';
import 'package:flutter_permission_handler_plus/src/permission_status.dart';
import 'package:flutter_permission_handler_plus/src/permission_type.dart';

/// Web implementation of the permission handler.
class FlutterPermissionHandlerPlusWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_permission_handler_plus',
      const StandardMethodCodec(),
      registrar,
    );
    final FlutterPermissionHandlerPlusWeb instance =
        FlutterPermissionHandlerPlusWeb();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<PermissionStatus> requestPermission(
    PermissionType permissionType, {
    PermissionConfig? config,
  }) async {
    // On Web, we can't request native permissions
    // Return granted status as a fallback
    return PermissionStatus.granted;
  }

  Future<Map<PermissionType, PermissionStatus>> requestPermissions(
    Map<PermissionType, PermissionConfig> permissions,
  ) async {
    final Map<PermissionType, PermissionStatus> results = {};
    for (final permission in permissions.keys) {
      results[permission] =
          await requestPermission(permission, config: permissions[permission]);
    }
    return results;
  }

  Future<PermissionStatus> checkPermissionStatus(
    PermissionType permissionType,
  ) async {
    // On Web, we can't check native permission status
    // Return granted status as a fallback
    return PermissionStatus.granted;
  }

  Future<Map<PermissionType, PermissionStatus>> checkPermissionStatuses(
    List<PermissionType> permissionTypes,
  ) async {
    final Map<PermissionType, PermissionStatus> results = {};
    for (final permission in permissionTypes) {
      results[permission] = await checkPermissionStatus(permission);
    }
    return results;
  }

  Future<bool> openAppSettings() async {
    // On Web, we can't open app settings
    return false;
  }

  Future<bool> isPermanentlyDenied(PermissionType permissionType) async {
    // On Web, permissions are not permanently denied
    return false;
  }

  Future<bool> shouldShowRequestPermissionRationale(
    PermissionType permissionType,
  ) async {
    // On Web, we don't need to show rationale
    return false;
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'requestPermission':
        final String permissionName = call.arguments['permission'] as String;
        final permissionType = PermissionType.values.firstWhere(
          (e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        final result = await requestPermission(permissionType);
        return result.index;
      case 'checkPermissionStatus':
        final String permissionName = call.arguments['permission'] as String;
        final permissionType = PermissionType.values.firstWhere(
          (e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        final result = await checkPermissionStatus(permissionType);
        return result.index;
      case 'shouldShowRequestPermissionRationale':
        final String permissionName = call.arguments['permission'] as String;
        final permissionType = PermissionType.values.firstWhere(
          (e) => e.name == permissionName,
          orElse: () => PermissionType.camera,
        );
        return shouldShowRequestPermissionRationale(permissionType);
      case 'openAppSettings':
        return openAppSettings();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'flutter_permission_handler_plus for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
}
