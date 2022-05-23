//
//  PriorityButton.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 14/12/21.
//

import SwiftUI

struct PriorityButton: View {
    @Binding var isOn: Bool
    
    var body: some View {
        
        Button(action: {
             self.isOn
                .toggle()
         }, label: {
        
             Image(systemName: "flag.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(Color(.systemOrange))
                    .opacity(isOn ? 1.0 : 0.3)
            
         }//label
               )//action
            .buttonStyle(HighPriorityButtonStyle())
    }
}

struct PriorityButton_Previews: PreviewProvider {
    static var previews: some View {
        PriorityButton(isOn: .constant(false))
    }
}
