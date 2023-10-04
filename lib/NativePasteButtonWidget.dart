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
  Map<String, dynamic> seed = {};
  late final MethodChannel channelPasteButton;
  final String channelUUID =
      NativeSwiftuiPastebuttonAndTextfield.uuid.v4().toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channelPasteButton = MethodChannel(channelUUID);
    seed["widgetUUID"] = channelUUID;
    seed["alpha"] = widget.color.alpha;
    seed["red"] = widget.color.red;
    seed["green"] = widget.color.green;
    seed["blue"] = widget.color.blue;
    seed["hasLabel"] = widget.hasLabel;
    seed["width"] = widget.width;
    seed["height"] = widget.height;

    NativeSwiftuiPastebuttonAndTextfieldPlatform.instance
        .callNativePasteButton(seed);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      channelPasteButton.setMethodCallHandler((call) async {
        widget.onPressed(call.arguments);
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: UiKitView(
            viewType: channelUUID,
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      ),
    );
  }
}
