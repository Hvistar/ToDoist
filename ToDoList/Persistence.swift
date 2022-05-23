//
//  Persistence.swift
//  ToDoList
//
//  Created by Luigi Luca Coletta on 09/11/21.
//

import CoreData

struct PersistentController {
    
    static let shared = PersistentController() //static instance of a single persistent controller to be shared in between files
    
    let container: NSPersistentContainer
    init(){
        container = NSPersistentContainer(name: "ToDoList") //accessing the container by giving it the name "ToDoList"
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error:\(error)")
            } //load the persistent store into the persistent container, calls a completion handler upon success; NSError value will be populated if there is an error loading the persistent store
        })
    }
    
}
