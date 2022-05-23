//
//  SwiftUIView.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 13/12/21.
//

/* To make the button clickable in the Navigation Link we need a high priority button */

import SwiftUI

struct HighPriorityButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    
    private struct MyButton: View {
        @State var pressed = false
        let configuration: PrimitiveButtonStyle.Configuration
        
        var body: some View {
            let gesture = DragGesture(minimumDistance: 0)
                .onChanged { _ in self.pressed = true }
                .onEnded { value in
                    self.pressed = false
                    if value.translation.width < 10 && value.translation.height < 10 {
                        self.configuration.trigger()
                    }
                }
            
            return configuration.label
                .opacity(self.pressed ? 0.5 : 1.0)
                .highPriorityGesture(gesture)
        }
    }
}

//struct HighPriorityButtonStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        MyButton()
//    }
//}
