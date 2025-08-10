#include <flutter/plugin_registrar.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>

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

// static
void FlutterPermissionHandlerPlusPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrar* registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_permission_handler_plus",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterPermissionHandlerPlusPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto& call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterPermissionHandlerPlusPlugin::FlutterPermissionHandlerPlusPlugin() {}

FlutterPermissionHandlerPlusPlugin::~FlutterPermissionHandlerPlusPlugin() {}

void FlutterPermissionHandlerPlusPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue>& method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("requestPermission") == 0) {
    // On macOS, permissions are typically granted by default
    // Return granted status (1)
    result->Success(flutter::EncodableValue(1));
  } else if (method_call.method_name().compare("checkPermissionStatus") == 0) {
    // On macOS, permissions are typically granted by default
    // Return granted status (1)
    result->Success(flutter::EncodableValue(1));
  } else if (method_call.method_name().compare("shouldShowRequestPermissionRationale") == 0) {
    // On macOS, we don't need to show rationale
    result->Success(flutter::EncodableValue(false));
  } else if (method_call.method_name().compare("openAppSettings") == 0) {
    // On macOS, we can't open app settings for permissions
    result->Success(flutter::EncodableValue(false));
  } else {
    result->NotImplemented();
  }
}

}  // namespace flutter_permission_handler_plus

void FlutterPermissionHandlerPlusPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_permission_handler_plus::FlutterPermissionHandlerPlusPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrar>(registrar));
}
