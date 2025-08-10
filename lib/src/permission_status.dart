/// Represents the current status of a permission request.
enum PermissionStatus {
  /// Permission has been granted by the user
  granted,

  /// Permission has been denied by the user
  denied,

  /// Permission has been permanently denied (user selected "Don't ask again")
  permanentlyDenied,

  /// Permission is restricted (iOS only - parental controls, etc.)
  restricted,

  /// Permission request is not applicable on this platform
  notApplicable,

  /// Permission status is unknown or not determined yet
  undetermined,
}

/// Extension to provide utility methods for [PermissionStatus].
extension PermissionStatusExtension on PermissionStatus {
  /// Returns true if the permission is granted
  bool get isGranted => this == PermissionStatus.granted;

  /// Returns true if the permission is denied (but can be requested again)
  bool get isDenied => this == PermissionStatus.denied;

  /// Returns true if the permission is permanently denied
  bool get isPermanentlyDenied => this == PermissionStatus.permanentlyDenied;

  /// Returns true if the permission is restricted
  bool get isRestricted => this == PermissionStatus.restricted;

  /// Returns true if the permission is not applicable on this platform
  bool get isNotApplicable => this == PermissionStatus.notApplicable;

  /// Returns true if the permission status is undetermined
  bool get isUndetermined => this == PermissionStatus.undetermined;

  /// Returns true if the app should show rationale for this permission
  bool get shouldShowRationale => isDenied && !isPermanentlyDenied;

  /// Returns true if the user should be directed to app settings
  bool get shouldOpenSettings => isPermanentlyDenied;

  /// User-friendly description of the permission status
  String get description {
    switch (this) {
      case PermissionStatus.granted:
        return 'Permission granted';
      case PermissionStatus.denied:
        return 'Permission denied';
      case PermissionStatus.permanentlyDenied:
        return 'Permission permanently denied';
      case PermissionStatus.restricted:
        return 'Permission restricted';
      case PermissionStatus.notApplicable:
        return 'Permission not applicable';
      case PermissionStatus.undetermined:
        return 'Permission not determined';
    }
  }
}
