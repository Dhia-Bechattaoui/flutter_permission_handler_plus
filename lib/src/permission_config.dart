/// Configuration options for permission requests.
///
/// This class allows customization of the permission request flow,
/// including rationale messages, dialog appearance, and retry behavior.
class PermissionConfig {
  /// Creates a new permission configuration.
  const PermissionConfig({
    this.rationale,
    this.rationaleTitle,
    this.enableAutoRationale = true,
    this.enableSettingsRedirect = true,
    this.settingsRedirectMessage,
    this.settingsRedirectTitle,
    this.retryCount = 2,
    this.showPermissionIcon = true,
  });

  /// Custom rationale message explaining why the permission is needed.
  /// If null, uses the default rationale from PermissionType.defaultRationale.
  final String? rationale;

  /// Title for the rationale dialog.
  /// If null, uses a default title like "Permission Required".
  final String? rationaleTitle;

  /// Whether to automatically show rationale before requesting permission.
  /// Defaults to true.
  final bool enableAutoRationale;

  /// Whether to show a dialog offering to redirect to settings when permission
  /// is permanently denied. Defaults to true.
  final bool enableSettingsRedirect;

  /// Custom message for the settings redirect dialog.
  /// If null, uses a default message explaining how to enable the permission.
  final String? settingsRedirectMessage;

  /// Title for the settings redirect dialog.
  /// If null, uses a default title like "Permission Required".
  final String? settingsRedirectTitle;

  /// Maximum number of times to retry a permission request.
  /// Set to 0 to disable retries. Defaults to 2.
  final int retryCount;

  /// Whether to show an icon representing the permission in dialogs.
  /// Defaults to true.
  final bool showPermissionIcon;

  /// Creates a copy of this configuration with optional new values.
  PermissionConfig copyWith({
    String? rationale,
    String? rationaleTitle,
    bool? enableAutoRationale,
    bool? enableSettingsRedirect,
    String? settingsRedirectMessage,
    String? settingsRedirectTitle,
    int? retryCount,
    bool? showPermissionIcon,
  }) {
    return PermissionConfig(
      rationale: rationale ?? this.rationale,
      rationaleTitle: rationaleTitle ?? this.rationaleTitle,
      enableAutoRationale: enableAutoRationale ?? this.enableAutoRationale,
      enableSettingsRedirect:
          enableSettingsRedirect ?? this.enableSettingsRedirect,
      settingsRedirectMessage:
          settingsRedirectMessage ?? this.settingsRedirectMessage,
      settingsRedirectTitle:
          settingsRedirectTitle ?? this.settingsRedirectTitle,
      retryCount: retryCount ?? this.retryCount,
      showPermissionIcon: showPermissionIcon ?? this.showPermissionIcon,
    );
  }

  @override
  String toString() {
    return 'PermissionConfig('
        'rationale: $rationale, '
        'rationaleTitle: $rationaleTitle, '
        'enableAutoRationale: $enableAutoRationale, '
        'enableSettingsRedirect: $enableSettingsRedirect, '
        'settingsRedirectMessage: $settingsRedirectMessage, '
        'settingsRedirectTitle: $settingsRedirectTitle, '
        'retryCount: $retryCount, '
        'showPermissionIcon: $showPermissionIcon'
        ')';
  }
}
