//
//  ItemListTableViewController.swift
//  ShoppingList.io
//
//  Created by Jason Goodney on 8/31/18.
//  Copyright © 2018 Jason Goodney. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ItemTableViewCellDelegate, UISearchControllerDelegate {
    
    // MARK: - Properties
    var predicate: NSPredicate?
    let fetchResultController: NSFetchedResultsController<Item> = {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDateStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    var items: [Item] {
        guard let fetchedObjects = fetchResultController.fetchedObjects else { return [] }
        return fetchedObjects
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perfomFetch()
        
        fetchResultController.delegate = self
        fetchResultController.fetchRequest.predicate = predicate
        
        navigationItem.title = "ShoppingList.io"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Fetch Performer 🕺
    func perfomFetch() {
        do {
            try fetchResultController.performFetch()
        } catch let error {
            print("😳\nThere was an error in \(#function): \(error)\n\n\(error.localizedDescription)\n👿")
        }
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell.itemCell, for: indexPath) as? ItemTableViewCell

        cell?.delegate = self
        cell?.item = items[indexPath.row]

        return cell ?? UITableViewCell()
    }

    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            CoreDateStack.delete(item: item)
        }
    }
    
    // MARK: - ItemTableViewCellDelegate
    func toggleItemIsAdded(cell: ItemTableViewCell) {
        guard let isAdded = cell.item?.isAdded else { return }
        cell.item?.isAdded = !isAdded
        CoreDateStack.saveToPersistentStore()
    }

    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        Alerts.addItemAlert(fromVC: self,
                            title: "Add Item",
                            message: "Please add an item to your shopping list.",
                            textFieldPlaceholder: "Item",
                            submitButtonTitle: "Add")
    }
    
    // MARK: - NSFetchResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let newIndexPath = newIndexPath else { return }
            tableView.reloadRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation 🗺
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.segue.toUpdateName {
            guard let destinationVC = segue.destination as? ItemDetailViewController,
                let index = tableView.indexPathForSelectedRow?.row else { return }
            
            destinationVC.item = items[index]
        }
    }
    
}
