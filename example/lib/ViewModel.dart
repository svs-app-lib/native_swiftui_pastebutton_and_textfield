import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPageViewModel with ChangeNotifier {
  String messageNativeSide = "";
  String messageFlutterSide = "";

  void receiveNativeSideMassage(String? text) {
    if (text != null) {
      messageNativeSide = text;
    } else {
      messageNativeSide = 'got null...';
    }
    notifyListeners();
  }

  void receiveFlutterSideMassage({String? text}) async {
    if (text != null) {
      messageFlutterSide = text;
    } else {
      ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data == null || data.text == null) {
        messageFlutterSide = 'got null...';
        return;
      } else {
        messageFlutterSide = data.text!;
      }
    }

    notifyListeners();
  }
}
