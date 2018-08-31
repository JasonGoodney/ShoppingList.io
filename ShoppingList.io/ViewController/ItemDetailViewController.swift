//
//  ItemDetailViewController.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties
    var item: Item? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var updateNameTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Update View
    func updateView() {
        guard let item = item else { return }
        updateNameTextField.text = item.name
        updateNameTextField.becomeFirstResponder()
        updateNameTextField.delegate = self
        
        item.name = ""
    }
    
    // MARK: - Actions
    @IBAction func updateButtonTapped(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let item = item else { return }
        
        item.name = updateNameTextField.text
        CoreDateStack.saveToPersistentStore()
    }
}
