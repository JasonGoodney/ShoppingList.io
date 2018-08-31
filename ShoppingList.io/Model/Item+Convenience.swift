//
//  Item+Convenience.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @discardableResult
    convenience init(name: String, isAdded: Bool = false, context: NSManagedObjectContext = CoreDateStack.context) {
        self.init(context: context)
        
        self.name = name
        self.isAdded = isAdded
    }
}
