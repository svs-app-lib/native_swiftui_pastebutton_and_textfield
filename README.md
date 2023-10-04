# native_swiftui_pastebutton_and_textfield

This is a plugin that provides a paste button and text field from Native SwiftUI as widgets in Flutter.

This plugin requires Xcode to build, and the executable iOS version must be 16.0 or higher.

## Getting started
Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  native_swiftui_pastebutton_and_textfield: ^1.0.4
```

### Add import package

if you want PasteButton
```dart
import 'package:native_swiftui_pastebutton_and_textfield/NativePasteButtonWidget.dart';
```

if you want TextField
```dart
import 'package:native_swiftui_pastebutton_and_textfield/NativeTextFieldWidget.dart';
```

## Easy to use
The package is designed with maximum adaptation to large screens.<br>
Therefore, adding a widget to your screen will be very simple.
```dart
    Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NativeTextFieldWidget(
                labelText: "write hint",
                onUpdated: (String? text) {
                  print(text);
                }),
            NativePasteButtonWidget(
                width: 90, // default width
                height: 50, // default height
                color: Colors.redAccent,
                hasLabel: true,
                onPressed: (String? data) {
                  print(data);
                })
          ],
        ),
      ),
    );
```

### Reasons to Use this Plugin in iOS Flutter Project
Starting from iOS 16, when attempting to perform a paste operation programmatically, a prompt requesting user confirmation pops up. 
This prompt always appears for paste operations, except when using the native iOS text field's edit options menu, controls implementing the UIPasteControl, or keyboard shortcuts for pasting. 
This becomes a significant detriment to user experience. Imagine if you released a note-taking app and a paste pop-up appeared every time; because consumers lack the patience to turn off the notification from settings, that app would likely receive a one-star rating. 😰
In native iOS apps, the three aforementioned methods allow for prompt-less pasting. However, in Flutter apps, even if you paste through the edit options menu of the CupertinoTextField or use a keyboard shortcut, it's not treated as native pasting. In reality, it's executed programmatically, hence triggering the user permission prompt. Naturally, creating a paste button doesn't allow the implementation of UIPasteControl, leading to the appearance of the prompt.

![KakaoTalk_Video_2023-09-18-11-00-47](https://github.com/isolateV/native_swiftui_pastebutton_and_textfield/assets/124323250/cf298a60-e5ca-422f-b998-00a18a3c2398)

This issue is not limited to the Flutter framework. Regardless of the framework used, if you create a paste button using a regular button or a gesture detector, the prompt will appear.

This led me to believe there was a need for a native iOS view, prompting the creation of this plugin. The official Flutter page initially suggested using Platform Views to offer a native iOS view by leveraging UIKit components, which seemed to allow the implementation of UIPasteControl. While this works somewhat smoothly during the debugging phase, it results in the annoying prompt popping up in the release phase! Thus, I decided to utilize SwiftUI's PasteButton and adopted an approach to integrate SwiftUI views. This method worked efficiently, and I released an app on the App Store using it. 

![KakaoTalk_Video_2023-09-18-11-00-53](https://github.com/isolateV/native_swiftui_pastebutton_and_textfield/assets/124323250/f9741ef2-16b1-4a24-ae99-b6fd17226a5e)

Maybe, in the future, Flutter might support UIPasteControl. But for now, this plugin proves invaluable.


## Please ensure you check.
In Xcode, you must set the iOS build version to 16.0 or higher.
Upon initial launch, the iOS target version occasionally reverts to its previous setting, so please double-check.
I'm not sure if there's a way to specify the minimum deployment version in the plugin. 

just need to check the versions of the 3 items.

### 1

<img width="1063" alt="스크린샷 2023-09-18 오전 1 15 37" src="https://github.com/isolateV/native_swiftui_pastebutton_and_textfield/assets/124323250/e7242f78-39df-4520-8f35-b205282882b1">

### 2

<img width="1018" alt="스크린샷 2023-09-18 오전 1 15 48" src="https://github.com/isolateV/native_swiftui_pastebutton_and_textfield/assets/124323250/94f3ae56-d92c-41ff-ad2d-800a596d9d48">

### 3

<img width="1030" alt="스크린샷 2023-09-18 오전 1 16 03" src="https://github.com/isolateV/native_swiftui_pastebutton_and_textfield/assets/124323250/c63c5735-1c32-4aa2-9659-435b5c657d45">



### Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

