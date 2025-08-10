#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_permission_handler_plus.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_permission_handler_plus'
  s.version          = '0.0.1'
  s.summary          = 'An improved permission handler with better UX and automatic permission requests.'
  s.description      = <<-DESC
An improved permission handler with better UX and automatic permission requests for Flutter applications.
                       DESC
  s.homepage         = 'https://github.com/Dhia-Bechattaoui/flutter_permission_handler_plus'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Dhia Bechattaoui' => 'dhia.bechattaoui@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
