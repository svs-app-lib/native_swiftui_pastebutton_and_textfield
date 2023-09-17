import Flutter
import UIKit
import SwiftUI
import UniformTypeIdentifiers


class TextFieldFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    private var channel: FlutterMethodChannel
    private var seed: [String: Any]
    init(messenger: FlutterBinaryMessenger, seed:[String: Any]) {
        self.messenger = messenger
        self.channel = FlutterMethodChannel(
            name: seed["widgetUUID"] as! String,
            binaryMessenger: messenger
        )
        self.seed = seed
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return TextFieldPView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            channel: channel,
            seed: self.seed
        )
    }
}


class TextFieldPView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        channel: FlutterMethodChannel,
        seed: [String: Any]
    ) {
        _view = UIHostingController(rootView: TextFieldSwiftUIView(seed: seed){text in
            DispatchQueue.main.async {
                channel.invokeMethod("textUpdate", arguments: text)
            }
        }).view
        super.init()
    }
    
    func view()-> UIView {
        return _view
    }
    
}

