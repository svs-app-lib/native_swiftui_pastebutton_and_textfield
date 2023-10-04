//
//  SwiftUIPasteButtonView.swift
//  Runner
//
//  Created by kite on 2023/09/07.
//

import SwiftUI

struct PasteButtonSwiftUIView: View {
    @State var buttonID: String = ""
    var method:(String?) -> Void
    var color:Color
    var hasLabel:Bool = false
    var width:Double
    var height:Double
    init(seed:[String: Any] ,bodyColor:Color, method:@escaping(String?) -> Void) {
        buttonID = UUID().uuidString
        self.method = method
        self.color = bodyColor
        self.hasLabel = seed["hasLabel"] as! Bool
        self.width = seed["width"] as! Double
        self.height = seed["height"] as! Double
    }
    
    var body: some View {
        PasteButton(payloadType: String.self){strings in
            method(strings[0])
        }
        .labelStyle(includingText: hasLabel).tint(self.color)
        .id(buttonID)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            self.buttonID = UUID().uuidString
        }
        .frame(width: self.width, height: self.height)
        .edgesIgnoringSafeArea(.all) 
    }
    
}

extension View {
    @ViewBuilder
    func labelStyle(includingText: Bool) -> some View {
        if includingText {
            self.labelStyle(.titleAndIcon)
        } else {
            self.labelStyle(.iconOnly)
        }
    }
}
