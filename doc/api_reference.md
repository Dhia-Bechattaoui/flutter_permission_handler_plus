# API Reference

## Classes

### PermissionHandlerPlus

The main class for handling permissions with enhanced UX features.

#### Methods

##### `requestPermission(PermissionType permissionType, {PermissionConfig config})`

Requests a single permission with enhanced UX features.

**Parameters:**
- `permissionType`: The type of permission to request
- `config`: Optional configuration for customizing the request flow

**Returns:** `Future<PermissionStatus>` - The final permission status

**Throws:**
- `PermissionRequestException` - If the request fails
- `UnsupportedPermissionException` - If the permission is not supported

##### `requestPermissions(Map<PermissionType, PermissionConfig> permissions)`

Requests multiple permissions simultaneously.

**Parameters:**
- `permissions`: A map of permission types to their configurations

**Returns:** `Future<Map<PermissionType, PermissionStatus>>` - Map of permission statuses

##### `checkPermissionStatus(PermissionType permissionType, {bool useCache})`

Checks the current status of a permission without requesting it.

**Parameters:**
- `permissionType`: The type of permission to check
- `useCache`: Whether to use cached status (default: true)

**Returns:** `Future<PermissionStatus>` - The current permission status

##### `openAppSettings()`

Opens the app settings page for manual permission management.

**Returns:** `Future<bool>` - True if settings were opened successfully

## Enums

### PermissionType

Enumeration of supported permission types:
- `camera` - Camera access permission
- `microphone` - Microphone access permission
- `locationWhenInUse` - Location access when app is in use
- `locationAlways` - Location access always (background)
- `photos` - Photo library/gallery access permission
- `contacts` - Contacts access permission
- `calendar` - Calendar access permission
- `storage` - Storage/file access permission
- `notification` - Push notification permission

### PermissionStatus

Represents the current status of a permission:
- `granted` - Permission has been granted
- `denied` - Permission has been denied (can be requested again)
- `permanentlyDenied` - Permission permanently denied ("Don't ask again")
- `restricted` - Permission is restricted (iOS parental controls)
- `notApplicable` - Permission not applicable on this platform
- `undetermined` - Permission status is unknown

## Configuration

### PermissionConfig

Configuration class for customizing permission requests:

**Properties:**
- `rationale` - Custom rationale message
- `rationaleTitle` - Title for rationale dialog
- `enableAutoRationale` - Whether to show automatic rationale
- `enableSettingsRedirect` - Whether to enable settings navigation
- `settingsRedirectMessage` - Custom settings dialog message
- `settingsRedirectTitle` - Custom settings dialog title
- `retryCount` - Maximum number of retry attempts
- `showPermissionIcon` - Whether to show permission icons

## Exceptions

### PermissionException

Base class for all permission-related exceptions.

### PermissionRequestException

Thrown when a permission request fails.

### UnsupportedPermissionException

Thrown when a permission is not supported on the current platform.

### PermissionHandlerNotInitializedException

Thrown when the permission handler is not properly initialized.

### InvalidPermissionException

Thrown when attempting to request an invalid permission.
