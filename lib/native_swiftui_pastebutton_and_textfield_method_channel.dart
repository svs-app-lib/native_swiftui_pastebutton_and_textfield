import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_swiftui_pastebutton_and_textfield_platform_interface.dart';

/// An implementation of [NativeSwiftuiPastebuttonAndTextfieldPlatform] that uses method channels.
class MethodChannelNativeSwiftuiPastebuttonAndTextfield extends NativeSwiftuiPastebuttonAndTextfieldPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_swiftui_pastebutton_and_textfield');
  
  @override
  void callNativePasteButton(Map widgetSeed) {
    methodChannel.invokeMethod('makePasteButtonWidget', widgetSeed);
  }

  @override
  void callNativeTextField(Map widgetSeed) {
    methodChannel.invokeMethod('makeTextFieldWidget', widgetSeed);
  }
}
