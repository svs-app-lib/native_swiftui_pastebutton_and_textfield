import Flutter
import UIKit
import SwiftUI
import UniformTypeIdentifiers

class PasteButtonFactory: NSObject, FlutterPlatformViewFactory {
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
        return PasteButtonPView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger,
            channel: channel,
            seed: self.seed
        )
    }
}


class PasteButtonPView: NSObject, FlutterPlatformView {
    private var _view: UIView
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?,
        channel: FlutterMethodChannel,
        seed: [String: Any]
    ) {
        let color = UIColor(red: seed["red"] as! Double / 255, green: seed["green"] as! Double / 255, blue: seed["blue"] as! Double / 255, alpha: seed["alpha"] as! Double/255)
        _view = UIHostingController(rootView: PasteButtonSwiftUIView(seed:seed, bodyColor: Color(color)){data in
            DispatchQueue.main.async {
                channel.invokeMethod("pasteAction", arguments: data)
            }
        }).view
        _view.backgroundColor = color
        _view.translatesAutoresizingMaskIntoConstraints = false
        super.init()
    }
    
    func view()-> UIView {
        return _view
    }
}

