//
//  Extension.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 13/12/21.
//

import UIKit
import Foundation

extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }
