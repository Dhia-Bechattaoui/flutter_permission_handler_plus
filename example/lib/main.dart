import 'package:flutter/material.dart';
import 'package:flutter_permission_handler_plus/flutter_permission_handler_plus.dart';

void main() {
  runApp(const PermissionHandlerPlusExampleApp());
}

/// Example app demonstrating flutter_permission_handler_plus features.
class PermissionHandlerPlusExampleApp extends StatelessWidget {
  /// Creates the example app.
  const PermissionHandlerPlusExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Permission Handler Plus Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PermissionDemoPage(),
    );
  }
}

/// Main page demonstrating permission requests with enhanced UX.
class PermissionDemoPage extends StatefulWidget {
  /// Creates the permission demo page.
  const PermissionDemoPage({super.key});

  @override
  State<PermissionDemoPage> createState() => _PermissionDemoPageState();
}

class _PermissionDemoPageState extends State<PermissionDemoPage> {
  final Map<PermissionType, PermissionStatus> _permissionStatuses = {};
  final PermissionHandlerPlus _permissionHandler =
      PermissionHandlerPlus.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAllPermissions();
  }

  /// Checks the status of all supported permissions.
  Future<void> _checkAllPermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final statuses = await _permissionHandler.checkPermissionStatuses(
        PermissionType.values,
      );

      setState(() {
        _permissionStatuses.addAll(statuses);
      });
    } catch (e) {
      _showErrorSnackBar('Failed to check permissions: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Requests a single permission with custom configuration.
  Future<void> _requestPermission(PermissionType permission) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final config = PermissionConfig(
        rationale: _getCustomRationale(permission),
      );

      final status = await _permissionHandler.requestPermission(
        permission,
        config: config,
      );

      setState(() {
        _permissionStatuses[permission] = status;
      });

      _showStatusSnackBar(permission, status);
    } catch (e) {
      _showErrorSnackBar('Failed to request ${permission.displayName}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Requests multiple permissions simultaneously.
  Future<void> _requestMultiplePermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final permissions = {
        PermissionType.camera: const PermissionConfig(
          rationale: 'We need camera access to take photos for your profile.',
        ),
        PermissionType.microphone: const PermissionConfig(
          rationale: 'We need microphone access to record voice messages.',
        ),
        PermissionType.photos: const PermissionConfig(
          rationale: 'We need photo access to select images from your gallery.',
        ),
      };

      final statuses = await _permissionHandler.requestPermissions(permissions);

      setState(() {
        _permissionStatuses.addAll(statuses);
      });

      _showMultipleStatusSnackBar(statuses);
    } catch (e) {
      _showErrorSnackBar('Failed to request multiple permissions: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Opens app settings for manual permission management.
  Future<void> _openAppSettings() async {
    final opened = await _permissionHandler.openAppSettings();
    if (opened) {
      _showSuccessSnackBar('Settings opened successfully');
      // Refresh permissions after user returns from settings
      await Future<void>.delayed(const Duration(seconds: 1));
      await _checkAllPermissions();
    } else {
      _showErrorSnackBar('Failed to open app settings');
    }
  }

  /// Gets custom rationale message for a permission.
  String _getCustomRationale(PermissionType permission) {
    switch (permission) {
      case PermissionType.camera:
        return 'This example app demonstrates camera permission with enhanced UX. '
            'Camera access allows you to take photos directly within the app.';
      case PermissionType.microphone:
        return 'This example shows how microphone permission requests work with '
            'automatic rationale dialogs and smart retry logic.';
      case PermissionType.locationWhenInUse:
        return 'Location permission demo with improved user experience. '
            'This allows the app to access your location while in use.';
      case PermissionType.locationAlways:
        return 'Background location access demo with clear explanation of why '
            'this sensitive permission is needed.';
      case PermissionType.photos:
        return 'Photo library access demonstration with better UX flow. '
            'This allows selecting images from your gallery.';
      case PermissionType.contacts:
        return 'Contacts permission example showing how to request access '
            'to your contact list with clear rationale.';
      case PermissionType.calendar:
        return 'Calendar permission demo with enhanced user experience. '
            'This allows the app to read and write calendar events.';
      case PermissionType.storage:
        return 'Storage permission demonstration showing file access '
            'with improved permission flow.';
      case PermissionType.notification:
        return 'Notification permission example with better UX. '
            'This allows the app to send you important updates.';
    }
  }

  /// Shows success message in snack bar.
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows error message in snack bar.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows permission status in snack bar.
  void _showStatusSnackBar(PermissionType permission, PermissionStatus status) {
    final color = status.isGranted ? Colors.green : Colors.orange;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${permission.displayName}: ${status.description}'),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Shows multiple permission statuses in snack bar.
  void _showMultipleStatusSnackBar(
      Map<PermissionType, PermissionStatus> statuses) {
    final granted = statuses.values.where((status) => status.isGranted).length;
    final total = statuses.length;

    final color = granted == total ? Colors.green : Colors.orange;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Permissions granted: $granted/$total'),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Gets color for permission status.
  Color _getStatusColor(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.orange;
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.restricted:
        return Colors.purple;
      case PermissionStatus.notApplicable:
        return Colors.grey;
      case PermissionStatus.undetermined:
        return Colors.blue;
    }
  }

  /// Gets icon for permission type.
  IconData _getPermissionIcon(PermissionType permission) {
    switch (permission) {
      case PermissionType.camera:
        return Icons.camera_alt;
      case PermissionType.microphone:
        return Icons.mic;
      case PermissionType.locationWhenInUse:
      case PermissionType.locationAlways:
        return Icons.location_on;
      case PermissionType.photos:
        return Icons.photo_library;
      case PermissionType.contacts:
        return Icons.contacts;
      case PermissionType.calendar:
        return Icons.calendar_today;
      case PermissionType.storage:
        return Icons.folder;
      case PermissionType.notification:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Permission Handler Plus Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _checkAllPermissions,
            tooltip: 'Refresh permissions',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openAppSettings,
            tooltip: 'Open app settings',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enhanced Permission Management',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This example demonstrates improved UX with automatic '
                        'rationale dialogs, smart retry logic, and seamless '
                        'settings integration.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed:
                              _isLoading ? null : _requestMultiplePermissions,
                          icon: const Icon(Icons.group_add),
                          label: const Text('Request Multiple'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _checkAllPermissions,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Refresh All'),
                        ),
                      ),
                    ],
                  ),
                ),

                // Permissions list
                Expanded(
                  child: ListView.builder(
                    itemCount: PermissionType.values.length,
                    itemBuilder: (context, index) {
                      final permission = PermissionType.values[index];
                      final status = _permissionStatuses[permission] ??
                          PermissionStatus.undetermined;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              _getStatusColor(status).withValues(alpha: 0.2),
                          child: Icon(
                            _getPermissionIcon(permission),
                            color: _getStatusColor(status),
                          ),
                        ),
                        title: Text(permission.displayName),
                        subtitle: Text(status.description),
                        trailing: status.isGranted
                            ? const Icon(Icons.check_circle,
                                color: Colors.green)
                            : IconButton(
                                icon: const Icon(Icons.security),
                                onPressed: _isLoading
                                    ? null
                                    : () => _requestPermission(permission),
                                tooltip: 'Request permission',
                              ),
                        onTap: _isLoading
                            ? null
                            : () => _requestPermission(permission),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _openAppSettings,
        icon: const Icon(Icons.settings),
        label: const Text('Settings'),
        tooltip: 'Open app settings for manual permission management',
      ),
    );
  }
}
