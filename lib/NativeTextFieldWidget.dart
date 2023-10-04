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
  Map<String, dynamic> seed = {};
  late final MethodChannel channelTextField;
  final String channelUUID =
      NativeSwiftuiPastebuttonAndTextfield.uuid.v4().toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channelTextField = MethodChannel(channelUUID);
    seed["widgetUUID"] = channelUUID;
    seed["labelText"] = widget.labelText;

    NativeSwiftuiPastebuttonAndTextfieldPlatform.instance
        .callNativeTextField(seed);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      channelTextField.setMethodCallHandler((call) async {
        widget.onUpdated(call.arguments);
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
          child: UiKitView(
            viewType: channelUUID,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        );
      }),
    );
  }
}
