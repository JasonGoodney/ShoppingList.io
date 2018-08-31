//
//  CoreDataStack.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation
import CoreData

enum CoreDateStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingList.io")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print("😰 Unresolved error: \(error)\n\(error.localizedDescription)")
            }
        })
        
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
    static func saveToPersistentStore() {
        
        do {
            try CoreDateStack.context.save()
        } catch let error {
            print("😳\nThere was an error in \(#function): \(error)\n\n\(error.localizedDescription)\n👿")
        }
    }
    
    static func delete(item: Item) {
        CoreDateStack.context.delete(item)
        saveToPersistentStore()
    }
}

