import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ViewModel.dart';
import 'package:native_swiftui_pastebutton_and_textfield/NativePasteButtonWidget.dart';
import 'package:native_swiftui_pastebutton_and_textfield/NativeTextFieldWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageViewModel(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFFEEEEEE),
          appBar: AppBar(
            title: const Text("Example"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "플러터 입력: ${context.watch<MainPageViewModel>().messageFlutterSide}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "네이티브 입력: ${context.watch<MainPageViewModel>().messageNativeSide}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("플러터 위젯", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 5),
                        TextField(
                            onChanged: (value) {
                              context
                                  .read<MainPageViewModel>()
                                  .receiveFlutterSideMassage(text: value);
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                                filled: true,
                                labelText: "플러터 입력창 입니다.",
                                hintText: "플러터 입력창",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0,
                                    )))),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("플러터 버튼",
                                style: TextStyle(fontSize: 17)),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 8,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<MainPageViewModel>()
                                      .receiveFlutterSideMassage();
                                },
                                child: const SizedBox(
                                  width: 90,
                                  height: 50,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.paste,
                                          size: 30,
                                        ),
                                        Text(
                                          "Paste",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text("네이티브 뷰", style: TextStyle(fontSize: 18)),
                        NativeTextFieldWidget(
                          width: 360,
                          height: 60,
                          onUpdated: (String? text) {
                            context
                                .read<MainPageViewModel>()
                                .receiveNativeSideMassage(text);
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("ios SwiftUI 버튼",
                                style: TextStyle(fontSize: 17)),
                            const SizedBox(
                              width: 9,
                            ),
                            NativePasteButtonWidget(
                              color: const Color(0xffe31937),
                              hasLabel: true,
                              onPressed: (String? data) {
                                context
                                    .read<MainPageViewModel>()
                                    .receiveNativeSideMassage(data);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}