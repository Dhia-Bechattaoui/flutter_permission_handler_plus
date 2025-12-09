# flutter_permission_handler_plus

[![Pub Version](https://img.shields.io/pub/v/flutter_permission_handler_plus)](https://pub.dev/packages/flutter_permission_handler_plus)
[![Pub Points](https://img.shields.io/pub/points/flutter_permission_handler_plus)](https://pub.dev/packages/flutter_permission_handler_plus/score)
[![Popularity](https://img.shields.io/pub/popularity/flutter_permission_handler_plus)](https://pub.dev/packages/flutter_permission_handler_plus/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An improved permission handler with better UX and automatic permission requests for Flutter applications.

<p align="center">
  <img src="assets/example.gif" alt="Example usage" width="300" />
</p>

## 🌟 Features

- **Real permission handling**: Built on top of the `permission_handler` plugin for fully functional platform requests
- **Smart Retry Logic**: Configurable retry loop for denied permissions
- **Settings Integration**: One-call navigation to app settings for manual permission management
- **Batch Requests**: Request multiple permissions in one call with combined results
- **Type Safety**: Strongly typed permission models and status helpers
- **Caching**: Optional permission status cache to reduce platform calls
- **Platform Support**: iOS 12.0+ and Android API 21+ (Android 5.0+)

## ✅ Development Requirements

- Quality: pana 160/160; `flutter analyze` and `dart analyze` clean; target test coverage >90%; comprehensive docs with examples
- SDKs: Dart >= 3.8.0; Flutter >= 3.32.0
- Platforms: iOS, Android, Web, Windows, macOS, Linux (WASM compatible)
- Project hygiene: semantic versioning, `.gitignore`, `CHANGELOG`, pub.dev guidelines followed

## 🚀 Key Improvements Over Standard Permission Handling

| Feature | Standard Approach | flutter_permission_handler_plus |
|---------|------------------|----------------------------------|
| Rationale Handling | Manual implementation required | ✅ Uses platform rationale hints with optional retry |
| Retry Logic | Handle manually | ✅ Configurable retry attempts |
| Settings Navigation | Complex setup | ✅ One-call settings integration |
| User Guidance | Basic status only | ✅ Status helpers for UI |
| Batch Requests | Sequential requests | ✅ Optimized parallel processing |
| Error Handling | Generic exceptions | ✅ Dedicated exception types |

## 📱 Supported Permissions

| Permission | iOS | Android | Description |
|------------|-----|---------|-------------|
| Camera | ✅ | ✅ | Camera access for photos/videos |
| Microphone | ✅ | ✅ | Microphone access for audio recording |
| Location (When in Use) | ✅ | ✅ | Location access while app is active |
| Location (Always) | ✅ | ✅ | Background location access |
| Photo Library | ✅ | ✅ | Access to device photo gallery |
| Contacts | ✅ | ✅ | Access to device contacts |
| Calendar | ✅ | ✅ | Access to device calendar |
| Storage | ✅ | ✅ | File system access |
| Notifications | ✅ | ✅ | Push notification permissions |

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_permission_handler_plus: ^0.0.2
```

Then run:

```bash
flutter pub get
```

## 🛠️ Platform Setup

### Android

Add the following permissions to your `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- Required permissions -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />

<!-- For Android 13+ (API 33+) -->
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
```

### iOS

Add the following to your `ios/Runner/Info.plist`:

```xml
<dict>
    <!-- Camera Permission -->
    <key>NSCameraUsageDescription</key>
    <string>This app needs camera access to take photos and videos.</string>
    
    <!-- Microphone Permission -->
    <key>NSMicrophoneUsageDescription</key>
    <string>This app needs microphone access to record audio.</string>
    
    <!-- Location Permissions -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>This app needs location access to provide location-based features.</string>
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>This app needs location access to provide location-based features.</string>
    
    <!-- Photo Library Permission -->
    <key>NSPhotoLibraryUsageDescription</key>
    <string>This app needs access to photo library to select images.</string>
    
    <!-- Contacts Permission -->
    <key>NSContactsUsageDescription</key>
    <string>This app needs access to contacts to help you connect with friends.</string>
    
    <!-- Calendar Permission -->
    <key>NSCalendarsUsageDescription</key>
    <string>This app needs access to calendar to manage events.</string>
</dict>
```

## 🎯 Usage

### Basic Permission Request

```dart
import 'package:flutter_permission_handler_plus/flutter_permission_handler_plus.dart';

// Simple permission request with automatic UX handling
final status = await PermissionHandlerPlus.instance.requestPermission(
  PermissionType.camera,
);

if (status.isGranted) {
  // Permission granted - proceed with camera functionality
  print('Camera permission granted!');
} else if (status.isPermanentlyDenied) {
  // User needs to enable permission in settings
  print('Please enable camera permission in settings');
}
```

### Custom Configuration

```dart
// Request permission with custom rationale and settings
final config = PermissionConfig(
  rationale: 'We need camera access to let you take profile photos.',
  rationaleTitle: 'Camera Permission Required',
  enableAutoRationale: true,
  enableSettingsRedirect: true,
  retryCount: 2,
  showPermissionIcon: true,
);

final status = await PermissionHandlerPlus.instance.requestPermission(
  PermissionType.camera,
  config: config,
);
```

### Multiple Permissions

```dart
// Request multiple permissions efficiently
final permissions = {
  PermissionType.camera: PermissionConfig(
    rationale: 'Camera access for taking photos',
  ),
  PermissionType.microphone: PermissionConfig(
    rationale: 'Microphone access for recording audio',
  ),
  PermissionType.photos: PermissionConfig(
    rationale: 'Photo library access for selecting images',
  ),
};

final statuses = await PermissionHandlerPlus.instance.requestPermissions(permissions);

// Check results
statuses.forEach((permission, status) {
  print('${permission.displayName}: ${status.description}');
});
```

### Permission Status Checking

```dart
// Check single permission status
final status = await PermissionHandlerPlus.instance.checkPermissionStatus(
  PermissionType.camera,
);

// Check multiple permission statuses
final statuses = await PermissionHandlerPlus.instance.checkPermissionStatuses([
  PermissionType.camera,
  PermissionType.microphone,
  PermissionType.photos,
]);
```

### Settings Integration

```dart
// Open app settings for manual permission management
final opened = await PermissionHandlerPlus.instance.openAppSettings();
if (opened) {
  print('Settings opened successfully');
}
```

### Advanced Features

```dart
// Check if rationale should be shown (Android)
final shouldShow = await PermissionHandlerPlus.instance
    .shouldShowRequestPermissionRationale(PermissionType.camera);

// Clear permission cache
PermissionHandlerPlus.instance.clearCache();
```

## 🎨 Custom UI Integration

```dart
class PermissionButton extends StatefulWidget {
  final PermissionType permission;
  final VoidCallback? onGranted;
  
  const PermissionButton({
    super.key,
    required this.permission,
    this.onGranted,
  });

  @override
  State<PermissionButton> createState() => _PermissionButtonState();
}

class _PermissionButtonState extends State<PermissionButton> {
  PermissionStatus _status = PermissionStatus.undetermined;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final status = await PermissionHandlerPlus.instance
        .checkPermissionStatus(widget.permission);
    setState(() {
      _status = status;
    });
  }

  Future<void> _requestPermission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final status = await PermissionHandlerPlus.instance.requestPermission(
        widget.permission,
        config: PermissionConfig(
          rationale: 'This feature requires ${widget.permission.displayName} access.',
        ),
      );

      setState(() {
        _status = status;
      });

      if (status.isGranted) {
        widget.onGranted?.call();
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading || _status.isGranted ? null : _requestPermission,
      icon: _isLoading 
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(_getStatusIcon()),
      label: Text(_getButtonText()),
      style: ElevatedButton.styleFrom(
        backgroundColor: _getButtonColor(),
      ),
    );
  }

  IconData _getStatusIcon() {
    if (_status.isGranted) return Icons.check;
    if (_status.isPermanentlyDenied) return Icons.settings;
    return Icons.security;
  }

  String _getButtonText() {
    if (_status.isGranted) return 'Granted';
    if (_status.isPermanentlyDenied) return 'Open Settings';
    return 'Grant ${widget.permission.displayName}';
  }

  Color _getButtonColor() {
    if (_status.isGranted) return Colors.green;
    if (_status.isPermanentlyDenied) return Colors.orange;
    return Colors.blue;
  }
}
```

## 🏗️ Architecture

The plugin follows a clean architecture pattern:

```
lib/
├── flutter_permission_handler_plus.dart     # Main export file
└── src/
    ├── permission_handler_plus.dart         # Core permission handler
    ├── permission_type.dart                 # Permission enumeration
    ├── permission_status.dart               # Status enumeration  
    ├── permission_config.dart               # Configuration class
    └── exceptions.dart                      # Custom exceptions
```

## 🔧 Configuration Options

### PermissionConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `rationale` | `String?` | `null` | Custom rationale message |
| `rationaleTitle` | `String?` | `null` | Custom rationale dialog title |
| `enableAutoRationale` | `bool` | `true` | Auto-show rationale dialogs |
| `enableSettingsRedirect` | `bool` | `true` | Enable settings navigation |
| `settingsRedirectMessage` | `String?` | `null` | Custom settings dialog message |
| `settingsRedirectTitle` | `String?` | `null` | Custom settings dialog title |
| `retryCount` | `int` | `2` | Maximum retry attempts |
| `showPermissionIcon` | `bool` | `true` | Show permission icons in dialogs |

## 🧪 Testing

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_permission_handler_plus/flutter_permission_handler_plus.dart';

void main() {
  group('PermissionHandlerPlus', () {
    test('should return granted status for granted permission', () async {
      // Mock test implementation
      final handler = PermissionHandlerPlus.instance;
      
      // Test permission request
      final status = await handler.requestPermission(PermissionType.camera);
      
      expect(status, isA<PermissionStatus>());
    });
  });
}
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the excellent framework
- Contributors to permission_handler for inspiration
- The Flutter community for feedback and suggestions

## 📞 Support

- 📧 **Email**: dhia.bechattaoui@example.com
- 🐛 **Issues**: [GitHub Issues](https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus/discussions)

## 🔄 Migration Guide

### From permission_handler

```dart
// Old way (permission_handler)
import 'package:permission_handler/permission_handler.dart';

var status = await Permission.camera.request();

// New way (flutter_permission_handler_plus)
import 'package:flutter_permission_handler_plus/flutter_permission_handler_plus.dart';

final status = await PermissionHandlerPlus.instance.requestPermission(
  PermissionType.camera,
  config: PermissionConfig(
    rationale: 'We need camera access for photos',
    enableAutoRationale: true,
  ),
);
```

---

**Made with ❤️ by [Dhia Bechattaoui](https://github.com/Dhia-Bechattaoui)**
