//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 25/10/21.
//

import SwiftUI

@main
struct ToDoListApp: App {

    var body: some Scene {
        
        let persistentContainer = PersistentController.shared //accessing the persistent container form the shared instance
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.container.viewContext) //persistentContainer is the NSPersistentContainer instance that contains the NSManagedObjectContext instance in its viewContent property -> it allows users to fetch/save data objects from the core data stack; \.managedObjectContext allows us to inject the viewContext into the view environment
        }
    }
}
