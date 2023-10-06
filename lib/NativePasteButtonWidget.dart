import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'native_swiftui_pastebutton_and_textfield.dart';
import 'native_swiftui_pastebutton_and_textfield_platform_interface.dart';

class NativePasteButtonWidget extends StatefulWidget {
  const NativePasteButtonWidget({
    super.key,
    this.width = 90,
    this.height = 50,
    required this.color,
    this.elevation = 8,
    this.hasLabel = true,
    required this.onPressed,
  });

  final double width;
  final double height;
  final Color color;
  final double elevation;
  final bool hasLabel;
  final void Function(String?) onPressed;

  @override
  State<NativePasteButtonWidget> createState() =>
      _NativePasteButtonWidgetState();
}

class _NativePasteButtonWidgetState extends State<NativePasteButtonWidget> {
  late final MethodChannel channelPasteButton;
  final String channelUUID =
      NativeSwiftuiPastebuttonAndTextfield.uuid.v4().toString();
  bool nativeReady = false;

  @override
  void initState() {
    super.initState();
    channelPasteButton = MethodChannel(channelUUID);
    channelPasteButton.setMethodCallHandler((call) async {
      widget.onPressed(call.arguments);
    });
    Map<String, dynamic> seed = {};
    seed["widgetUUID"] = channelUUID;
    seed["alpha"] = widget.color.alpha;
    seed["red"] = widget.color.red;
    seed["green"] = widget.color.green;
    seed["blue"] = widget.color.blue;
    seed["hasLabel"] = widget.hasLabel;
    seed["width"] = widget.width;
    seed["height"] = widget.height;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NativeSwiftuiPastebuttonAndTextfieldPlatform.instance
          .callNativeView('makePasteButtonWidget', seed, () {
        setState(() {
          nativeReady = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: widget.elevation,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: nativeReady
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: UiKitView(
                  viewType: channelUUID,
                  layoutDirection: TextDirection.ltr,
                  creationParamsCodec: const StandardMessageCodec(),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
