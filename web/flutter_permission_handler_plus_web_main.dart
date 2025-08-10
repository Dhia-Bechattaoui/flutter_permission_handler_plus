import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'flutter_permission_handler_plus_web.dart';

/// Main entry point for the web plugin.
/// This function is called by Flutter to register the plugin.
void registerWith(Registrar registrar) {
  FlutterPermissionHandlerPlusWeb.registerWith(registrar);
}
