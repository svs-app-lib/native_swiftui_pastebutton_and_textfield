import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_swiftui_pastebutton_and_textfield_method_channel.dart';

abstract class NativeSwiftuiPastebuttonAndTextfieldPlatform extends PlatformInterface {
  /// Constructs a NativeSwiftuiPastebuttonAndTextfieldPlatform.
  NativeSwiftuiPastebuttonAndTextfieldPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeSwiftuiPastebuttonAndTextfieldPlatform _instance = MethodChannelNativeSwiftuiPastebuttonAndTextfield();

  /// The default instance of [NativeSwiftuiPastebuttonAndTextfieldPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeSwiftuiPastebuttonAndTextfield].
  static NativeSwiftuiPastebuttonAndTextfieldPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeSwiftuiPastebuttonAndTextfieldPlatform] when
  /// they register themselves.
  static set instance(NativeSwiftuiPastebuttonAndTextfieldPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void callNativePasteButton(Map<String, dynamic> widgetSeed) {
    throw UnimplementedError('callNativePasteButton() has not been implemented.');
  }
  void callNativeTextField(Map<String, dynamic> widgetSeed) {
    throw UnimplementedError('callNativePasteButton() has not been implemented.');
  }
}
