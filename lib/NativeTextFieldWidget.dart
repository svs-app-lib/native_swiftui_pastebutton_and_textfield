import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'native_swiftui_pastebutton_and_textfield.dart';
import 'native_swiftui_pastebutton_and_textfield_platform_interface.dart';

class NativeTextFieldWidget extends StatefulWidget {
  const NativeTextFieldWidget({
    super.key,
    this.labelText = "",
    required this.onUpdated,
  });

  final String labelText;
  final void Function(String?) onUpdated;

  @override
  State<NativeTextFieldWidget> createState() => _NativeTextFieldWidgetState();
}

class _NativeTextFieldWidgetState extends State<NativeTextFieldWidget> {
  late final MethodChannel channelTextField;
  final String channelUUID =
      NativeSwiftuiPastebuttonAndTextfield.uuid.v4().toString();
  bool nativeReady = false;

  @override
  void initState() {
    super.initState();

    channelTextField = MethodChannel(channelUUID);
    channelTextField.setMethodCallHandler((call) async {
      widget.onUpdated(call.arguments);
    });
    Map<String, dynamic> seed = {};
    seed["widgetUUID"] = channelUUID;
    seed["labelText"] = widget.labelText;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NativeSwiftuiPastebuttonAndTextfieldPlatform.instance
          .callNativeView('makeTextFieldWidget', seed, () {
        setState(() {
          nativeReady = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: LayoutBuilder(builder: (context, dims) {
        return SizedBox(
          width: dims.maxWidth,
          child: nativeReady
              ? UiKitView(
                  viewType: channelUUID,
                  layoutDirection: TextDirection.ltr,
                  creationParamsCodec: const StandardMessageCodec(),
                )
              : const SizedBox(),
        );
      }),
    );
  }
}
