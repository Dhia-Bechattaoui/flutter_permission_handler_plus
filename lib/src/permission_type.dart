/// Enumeration of supported permission types.
///
/// Each permission type corresponds to a specific system permission
/// that can be requested from the user.
enum PermissionType {
  /// Camera access permission
  camera,

  /// Microphone access permission
  microphone,

  /// Location access when app is in use
  locationWhenInUse,

  /// Location access always (background)
  locationAlways,

  /// Photo library/gallery access permission
  photos,

  /// Contacts access permission
  contacts,

  /// Calendar access permission
  calendar,

  /// Storage/file access permission
  storage,

  /// Push notification permission
  notification,
}

/// Extension to provide human-readable names and descriptions for permissions.
extension PermissionTypeExtension on PermissionType {
  /// User-friendly name for the permission
  String get displayName {
    switch (this) {
      case PermissionType.camera:
        return 'Camera';
      case PermissionType.microphone:
        return 'Microphone';
      case PermissionType.locationWhenInUse:
        return 'Location (When in Use)';
      case PermissionType.locationAlways:
        return 'Location (Always)';
      case PermissionType.photos:
        return 'Photos';
      case PermissionType.contacts:
        return 'Contacts';
      case PermissionType.calendar:
        return 'Calendar';
      case PermissionType.storage:
        return 'Storage';
      case PermissionType.notification:
        return 'Notifications';
    }
  }

  /// Default rationale message explaining why the permission is needed
  String get defaultRationale {
    switch (this) {
      case PermissionType.camera:
        return 'This app needs camera access to take photos and videos.';
      case PermissionType.microphone:
        return 'This app needs microphone access to record audio.';
      case PermissionType.locationWhenInUse:
        return "This app needs location access to provide location-based features while you're using the app.";
      case PermissionType.locationAlways:
        return 'This app needs location access to provide location-based features even when the app is in the background.';
      case PermissionType.photos:
        return 'This app needs access to your photos to select and share images.';
      case PermissionType.contacts:
        return 'This app needs access to your contacts to help you connect with friends.';
      case PermissionType.calendar:
        return 'This app needs access to your calendar to manage events and appointments.';
      case PermissionType.storage:
        return 'This app needs storage access to save and access files.';
      case PermissionType.notification:
        return 'This app would like to send you notifications to keep you updated.';
    }
  }

  /// Icon name suggestion for UI representation
  String get iconName {
    switch (this) {
      case PermissionType.camera:
        return 'camera';
      case PermissionType.microphone:
        return 'mic';
      case PermissionType.locationWhenInUse:
      case PermissionType.locationAlways:
        return 'location_on';
      case PermissionType.photos:
        return 'photo_library';
      case PermissionType.contacts:
        return 'contacts';
      case PermissionType.calendar:
        return 'calendar_today';
      case PermissionType.storage:
        return 'folder';
      case PermissionType.notification:
        return 'notifications';
    }
  }
}
