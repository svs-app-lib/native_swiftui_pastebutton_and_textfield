//
//  TextFieldView.swift
//  Runner
//
//  Created by kite on 2023/09/12.
//

import SwiftUI

struct TextFieldSwiftUIView: View {
    @State var textValue:String = ""
    var method:(String?) -> Void
    var labelText = ""
    
    init(seed:[String: Any], method:@escaping (String?) -> Void) {
        self.method = method
        self.labelText = seed["labelText"] as! String
    }
    
    var body: some View {
        TextField(self.labelText, text: $textValue.onChange(perform: {
            self.method(self.textValue)
        }))
        .textFieldStyle(.roundedBorder)
        
    }
}


extension Binding {
    func onChange(perform action: @escaping () -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: {
                self.wrappedValue = $0
                action()
            }
        )
    }
}
