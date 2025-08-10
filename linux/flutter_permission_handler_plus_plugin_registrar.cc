#include <flutter/plugin_registrar.h>

#include "flutter_permission_handler_plus_plugin.h"

void FlutterPermissionHandlerPlusPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_permission_handler_plus::FlutterPermissionHandlerPlusPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrar>(registrar));
}
