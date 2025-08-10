# flutter_permission_handler_plus_example

This example app demonstrates the features and capabilities of the `flutter_permission_handler_plus` plugin.

## Features Demonstrated

- **Single Permission Requests**: Request individual permissions with custom rationale messages
- **Multiple Permission Requests**: Batch request multiple permissions simultaneously  
- **Enhanced UX**: Automatic rationale dialogs and smart retry logic
- **Settings Integration**: Direct navigation to app settings for manual permission management
- **Status Monitoring**: Real-time permission status checking and display
- **Custom Configuration**: Tailored permission flows with custom messages and settings

## Getting Started

1. Run `flutter pub get` in the example directory
2. Launch the app on an iOS or Android device
3. Try requesting different permissions to see the enhanced UX in action
4. Notice how the app automatically shows rationale dialogs and handles denials gracefully

## Permission Types Demonstrated

- 📷 Camera Access
- 🎤 Microphone Access  
- 📍 Location (When in Use)
- 📍 Location (Always)
- 🖼️ Photo Library Access
- 📞 Contacts Access
- 📅 Calendar Access
- 💾 Storage Access
- 🔔 Notification Access

## Key Features Highlighted

### Automatic Rationale
The app automatically shows rationale dialogs explaining why permissions are needed before requesting them.

### Smart Retry Logic
If a permission is denied, the app offers to retry with additional context, up to a configurable number of attempts.

### Settings Integration
For permanently denied permissions, the app offers to open the system settings where users can manually enable permissions.

### Batch Requests
Multiple related permissions can be requested together for a better user experience.

## Code Examples

The example app showcases:
- Simple permission requests with default configuration
- Custom permission configurations with tailored messages
- Multiple permission requests
- Permission status monitoring
- Error handling and user feedback

For more details, see the source code in `lib/main.dart`.
