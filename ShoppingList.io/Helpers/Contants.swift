//
//  Contants.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import Foundation

struct PersistentContainer {
    static let name = "ShoppingList.io"
}

struct Identifier {
    struct cell {
        static let itemCell = "itemCell"
    }
    
    struct segue {
        static let toUpdateName = "toUpdateName"
    }
}
