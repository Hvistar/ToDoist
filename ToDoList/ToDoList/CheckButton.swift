//
//  CheckButton.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 13/12/21.
//

import SwiftUI

struct CheckButton: View {
    
    @State var isOn: Bool = false
    
    var body: some View {
        
        Button(action: {
             self.isOn
                .toggle()
         }, label: {
        
             Image(systemName: "checkmark.circle.fill")
            .overlay(
                Circle()
                    .stroke(Color(.systemGray), lineWidth: 2)
            )
            .foregroundColor(isOn ? Color(.systemGreen) : Color(.white))
         }//label
               )//action
            .buttonStyle(HighPriorityButtonStyle())
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckButton()
    }
}
