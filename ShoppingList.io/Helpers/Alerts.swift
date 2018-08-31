//
//  Alerts.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

struct Alerts {
    
    /// Adds a new item to the shopping list and saves to Core Data
    /// *** Attempted to update the list item from this function ***
    ///
    /// - Parameters:
    ///   - vc: UIViewController
    ///   - title: String?
    ///   - message: String?
    ///   - textFieldPlaceholder: String? = nil
    ///   - submitButtonTitle: String = "Submit"
    ///   - item: Item? = nil
    static func addItemAlert(fromVC vc: UIViewController, title: String?, message: String?, textFieldPlaceholder: String? = nil, submitButtonTitle: String = "Submit", item: Item? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            if let item = item {
                textField.text = item.name
            } else {
                textField.placeholder = textFieldPlaceholder
            }
            
            textField.autocapitalizationType = .sentences
        }
        
        let submitAction = UIAlertAction(title: submitButtonTitle, style: .default) { _ in
            guard let itemName = alertController.textFields?[0].text, !itemName.isEmpty
                else { print("Emtpy alert textField"); return }
            
            if let item = item {
                item.name = itemName
            } else {
                Item(name: itemName)
            }
            
            CoreDateStack.saveToPersistentStore()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
