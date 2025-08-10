/// Base class for all permission-related exceptions.
abstract class PermissionException implements Exception {
  /// Creates a permission exception with an optional message.
  const PermissionException([this.message]);

  /// The error message.
  final String? message;

  @override
  String toString() {
    final msg = message;
    if (msg == null) return 'PermissionException';
    return 'PermissionException: $msg';
  }
}

/// Exception thrown when a permission request fails.
class PermissionRequestException extends PermissionException {
  /// Creates a permission request exception.
  const PermissionRequestException([super.message]);

  @override
  String toString() {
    final msg = message;
    if (msg == null) return 'PermissionRequestException';
    return 'PermissionRequestException: $msg';
  }
}

/// Exception thrown when a permission is not supported on the current platform.
class UnsupportedPermissionException extends PermissionException {
  /// Creates an unsupported permission exception.
  const UnsupportedPermissionException([super.message]);

  @override
  String toString() {
    final msg = message;
    if (msg == null) return 'UnsupportedPermissionException';
    return 'UnsupportedPermissionException: $msg';
  }
}

/// Exception thrown when the permission handler is not properly initialized.
class PermissionHandlerNotInitializedException extends PermissionException {
  /// Creates a permission handler not initialized exception.
  const PermissionHandlerNotInitializedException([super.message]);

  @override
  String toString() {
    final msg = message;
    if (msg == null) return 'PermissionHandlerNotInitializedException';
    return 'PermissionHandlerNotInitializedException: $msg';
  }
}

/// Exception thrown when attempting to request an invalid permission.
class InvalidPermissionException extends PermissionException {
  /// Creates an invalid permission exception.
  const InvalidPermissionException([super.message]);

  @override
  String toString() {
    final msg = message;
    if (msg == null) return 'InvalidPermissionException';
    return 'InvalidPermissionException: $msg';
  }
}
