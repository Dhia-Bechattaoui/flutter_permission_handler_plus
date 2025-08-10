#include <flutter/plugin_registrar_windows.h>

#include "flutter_permission_handler_plus_plugin.h"

// Must be before the PluginRegistrarManager include.
#include <flutter/plugin_registrar.h>

void FlutterPermissionHandlerPlusPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_permission_handler_plus::FlutterPermissionHandlerPlusPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
