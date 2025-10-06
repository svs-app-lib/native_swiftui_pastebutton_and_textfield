#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_swiftui_pastebutton_and_textfield.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_swiftui_pastebutton_and_textfield'
  s.version          = '1.0.1'
  s.summary          = 'This is a plugin that provides a paste button and text field from Native SwiftUI as widgets in Flutter.'
  s.description      = <<-DESC
This is a plugin that provides a paste button and text field from Native SwiftUI as widgets in Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
