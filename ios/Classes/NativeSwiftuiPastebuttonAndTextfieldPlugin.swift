import Flutter
import UIKit

public class NativeSwiftuiPastebuttonAndTextfieldPlugin: NSObject, FlutterPlugin {
    var channel:FlutterMethodChannel?
    var registrar: FlutterPluginRegistrar?
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_swiftui_pastebutton_and_textfield", binaryMessenger: registrar.messenger())
        let instance = NativeSwiftuiPastebuttonAndTextfieldPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        instance.channel = channel
        instance.registrar = registrar
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "makeTextFieldWidget":
            let widgetSeed = call.arguments as! [String : Any]
            let widgetUUID:String = widgetSeed["widgetUUID"] as! String
            let factory = TextFieldFactory(messenger: self.registrar!.messenger(), seed: widgetSeed)
            self.registrar!.register(factory, withId: widgetUUID)
            result(true)
            
        case "makePasteButtonWidget":
            let widgetSeed = call.arguments as! [String : Any]
            let widgetUUID:String = widgetSeed["widgetUUID"] as! String
            let factory = PasteButtonFactory(messenger: self.registrar!.messenger(), seed: widgetSeed)
            self.registrar!.register(factory, withId: widgetUUID)
            result(true)
            
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
    
}
