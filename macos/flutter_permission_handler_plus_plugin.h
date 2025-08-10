#ifndef FLUTTER_PLUGIN_FLUTTER_PERMISSION_HANDLER_PLUS_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_PERMISSION_HANDLER_PLUS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar.h>

#include <memory>

namespace flutter_permission_handler_plus {

class FlutterPermissionHandlerPlusPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrar* registrar);

  FlutterPermissionHandlerPlusPlugin();

  virtual ~FlutterPermissionHandlerPlusPlugin();

  // Disallow copy and assign.
  FlutterPermissionHandlerPlusPlugin(const FlutterPermissionHandlerPlusPlugin&) = delete;
  FlutterPermissionHandlerPlusPlugin& operator=(const FlutterPermissionHandlerPlusPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_permission_handler_plus

#endif  // FLUTTER_PLUGIN_FLUTTER_PERMISSION_HANDLER_PLUS_PLUGIN_H_
