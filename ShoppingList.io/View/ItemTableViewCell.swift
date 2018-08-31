//
//  ItemTableViewCell.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit

protocol ItemTableViewCellDelegate: class {
    func toggleItemIsAdded(cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: ItemTableViewCellDelegate?
    var item: Item? {
        didSet {
            updateView()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var isAddedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Update Views
    func updateView() {
        guard let item = item else { return }
        
        itemNameLabel.text = item.name
        if item.isAdded {
            isAddedButton.setTitle("☑️", for: .normal)
        } else {
            isAddedButton.setTitle("⬜️", for: .normal)
        }
    }

    // MARK: - Actions
    @IBAction func isAddedButtonTapped(_ sender: UIButton) {
        delegate?.toggleItemIsAdded(cell: self)
    }
}
