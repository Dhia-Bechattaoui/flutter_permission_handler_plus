import 'package:flutter_permission_handler_plus/flutter_permission_handler_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PermissionType', () {
    test('should have correct display names', () {
      expect(PermissionType.camera.displayName, 'Camera');
      expect(PermissionType.microphone.displayName, 'Microphone');
      expect(PermissionType.locationWhenInUse.displayName,
          'Location (When in Use)');
      expect(PermissionType.locationAlways.displayName, 'Location (Always)');
      expect(PermissionType.photos.displayName, 'Photos');
      expect(PermissionType.contacts.displayName, 'Contacts');
      expect(PermissionType.calendar.displayName, 'Calendar');
      expect(PermissionType.storage.displayName, 'Storage');
      expect(PermissionType.notification.displayName, 'Notifications');
    });

    test('should have default rationale messages', () {
      expect(
        PermissionType.camera.defaultRationale,
        'This app needs camera access to take photos and videos.',
      );
      expect(
        PermissionType.microphone.defaultRationale,
        'This app needs microphone access to record audio.',
      );
      expect(
        PermissionType.locationWhenInUse.defaultRationale,
        "This app needs location access to provide location-based features while you're using the app.",
      );
    });

    test('should have appropriate icon names', () {
      expect(PermissionType.camera.iconName, 'camera');
      expect(PermissionType.microphone.iconName, 'mic');
      expect(PermissionType.locationWhenInUse.iconName, 'location_on');
      expect(PermissionType.locationAlways.iconName, 'location_on');
      expect(PermissionType.photos.iconName, 'photo_library');
      expect(PermissionType.contacts.iconName, 'contacts');
      expect(PermissionType.calendar.iconName, 'calendar_today');
      expect(PermissionType.storage.iconName, 'folder');
      expect(PermissionType.notification.iconName, 'notifications');
    });
  });

  group('PermissionStatus', () {
    test('should have correct status checks', () {
      expect(PermissionStatus.granted.isGranted, true);
      expect(PermissionStatus.denied.isDenied, true);
      expect(PermissionStatus.permanentlyDenied.isPermanentlyDenied, true);
      expect(PermissionStatus.restricted.isRestricted, true);
      expect(PermissionStatus.notApplicable.isNotApplicable, true);
      expect(PermissionStatus.undetermined.isUndetermined, true);
    });

    test('should have correct rationale and settings checks', () {
      expect(PermissionStatus.denied.shouldShowRationale, true);
      expect(PermissionStatus.granted.shouldShowRationale, false);
      expect(PermissionStatus.permanentlyDenied.shouldShowRationale, false);

      expect(PermissionStatus.permanentlyDenied.shouldOpenSettings, true);
      expect(PermissionStatus.denied.shouldOpenSettings, false);
      expect(PermissionStatus.granted.shouldOpenSettings, false);
    });

    test('should have correct descriptions', () {
      expect(PermissionStatus.granted.description, 'Permission granted');
      expect(PermissionStatus.denied.description, 'Permission denied');
      expect(PermissionStatus.permanentlyDenied.description,
          'Permission permanently denied');
      expect(PermissionStatus.restricted.description, 'Permission restricted');
      expect(PermissionStatus.notApplicable.description,
          'Permission not applicable');
      expect(PermissionStatus.undetermined.description,
          'Permission not determined');
    });
  });

  group('PermissionConfig', () {
    test('should create with default values', () {
      const config = PermissionConfig();

      expect(config.rationale, null);
      expect(config.rationaleTitle, null);
      expect(config.enableAutoRationale, true);
      expect(config.enableSettingsRedirect, true);
      expect(config.settingsRedirectMessage, null);
      expect(config.settingsRedirectTitle, null);
      expect(config.retryCount, 2);
      expect(config.showPermissionIcon, true);
    });

    test('should create with custom values', () {
      const config = PermissionConfig(
        rationale: 'Custom rationale',
        rationaleTitle: 'Custom Title',
        enableAutoRationale: false,
        enableSettingsRedirect: false,
        settingsRedirectMessage: 'Custom settings message',
        settingsRedirectTitle: 'Custom Settings Title',
        retryCount: 5,
        showPermissionIcon: false,
      );

      expect(config.rationale, 'Custom rationale');
      expect(config.rationaleTitle, 'Custom Title');
      expect(config.enableAutoRationale, false);
      expect(config.enableSettingsRedirect, false);
      expect(config.settingsRedirectMessage, 'Custom settings message');
      expect(config.settingsRedirectTitle, 'Custom Settings Title');
      expect(config.retryCount, 5);
      expect(config.showPermissionIcon, false);
    });

    test('should support copyWith', () {
      const original = PermissionConfig(
        rationale: 'Original rationale',
        retryCount: 3,
      );

      final copied = original.copyWith(
        rationale: 'New rationale',
        enableAutoRationale: false,
      );

      expect(copied.rationale, 'New rationale');
      expect(copied.enableAutoRationale, false);
      expect(copied.retryCount, 3); // Should keep original value
    });

    test('should have correct equality', () {
      const config1 = PermissionConfig(rationale: 'Test');
      const config2 = PermissionConfig(rationale: 'Test');
      const config3 = PermissionConfig(rationale: 'Different');

      expect(config1, equals(config2));
      expect(config1, isNot(equals(config3)));
    });

    test('should have consistent hashCode', () {
      const config1 = PermissionConfig(rationale: 'Test');
      const config2 = PermissionConfig(rationale: 'Test');

      expect(config1.hashCode, equals(config2.hashCode));
    });

    test('should have meaningful toString', () {
      const config = PermissionConfig(
        rationale: 'Test rationale',
        retryCount: 3,
      );

      final string = config.toString();
      expect(string, contains('PermissionConfig'));
      expect(string, contains('Test rationale'));
      expect(string, contains('3'));
    });
  });

  group('Exceptions', () {
    test('PermissionException should have correct toString', () {
      const exception = PermissionRequestException('Test message');
      expect(exception.toString(), 'PermissionRequestException: Test message');

      const exceptionNoMessage = PermissionRequestException();
      expect(exceptionNoMessage.toString(), 'PermissionRequestException');
    });

    test('UnsupportedPermissionException should work correctly', () {
      const exception = UnsupportedPermissionException('Unsupported');
      expect(exception.message, 'Unsupported');
      expect(
          exception.toString(), 'UnsupportedPermissionException: Unsupported');
    });

    test('PermissionHandlerNotInitializedException should work correctly', () {
      const exception =
          PermissionHandlerNotInitializedException('Not initialized');
      expect(exception.message, 'Not initialized');
      expect(exception.toString(),
          'PermissionHandlerNotInitializedException: Not initialized');
    });

    test('InvalidPermissionException should work correctly', () {
      const exception = InvalidPermissionException('Invalid permission');
      expect(exception.message, 'Invalid permission');
      expect(exception.toString(),
          'InvalidPermissionException: Invalid permission');
    });
  });

  group('PermissionHandlerPlus', () {
    test('should be singleton', () {
      final instance1 = PermissionHandlerPlus();
      final instance2 = PermissionHandlerPlus();

      expect(identical(instance1, instance2), true);
    });

    test('should clear cache', () {
      final handler = PermissionHandlerPlus();

      // This should not throw
      expect(handler.clearCache, returnsNormally);
    });
  });
}
