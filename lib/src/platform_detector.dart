import 'package:flutter/foundation.dart';

/// Platform detection utility that works across all platforms.
///
/// This class provides platform detection without using dart:io,
/// making it compatible with WASM and all Flutter platforms.
class PlatformDetector {
  /// Private constructor to prevent instantiation.
  ///
  /// This class only contains static methods and should not be instantiated.
  const PlatformDetector._();

  /// Checks if the current platform is iOS.
  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  /// Checks if the current platform is Android.
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Checks if the current platform is Windows.
  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  /// Checks if the current platform is macOS.
  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  /// Checks if the current platform is Linux.
  static bool get isLinux => defaultTargetPlatform == TargetPlatform.linux;

  /// Checks if the current platform is Web.
  static bool get isWeb => kIsWeb;

  /// Gets the current platform name as a string.
  static String get platformName {
    if (kIsWeb) return 'web';

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.linux:
        return 'linux';
      default:
        return 'unknown';
    }
  }

  /// Checks if the current platform supports native permissions.
  ///
  /// Only mobile platforms (iOS, Android) support native permission requests.
  static bool get supportsNativePermissions => isIOS || isAndroid;

  /// Checks if the current platform supports file system operations.
  ///
  /// Desktop platforms support file system operations.
  static bool get supportsFileSystem => isWindows || isMacOS || isLinux;
}
