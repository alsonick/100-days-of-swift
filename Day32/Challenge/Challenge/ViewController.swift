//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 15/04/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Clear",
            style: .plain,
            target: self,
            action: #selector(clearShoppingList)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForShoppingItem)
        )
    }
    
    func addShoppingItem(_ item: String) {
        // Check if the item already exists
        for shoppingListItem in shoppingList {
            if shoppingListItem.lowercased() == item.lowercased() {
                displayAlert(title: "You Already have This Item", message: nil, preferredStyle: .alert)
                return
            }
        }

        
        shoppingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func displayAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func promptForShoppingItem() {
        let ac = UIAlertController(title: "Add Shopping Item", message: "What would you like to add today?", preferredStyle: .alert)
        ac.addTextField()
        
        let addShoppingItemAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let shoppingItem = ac?.textFields?[0].text else { return }
            self?.addShoppingItem(shoppingItem)
        }
        
        ac.addAction(addShoppingItemAction)
        present(ac, animated: true)
    }
    
    @objc func clearShoppingList() {
        let ac = UIAlertController(title: "Are You Sure?", message: "This action is irreversible, are you sure you want to continue?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { _ in
            self.shoppingList.removeAll(keepingCapacity: false)
            self.tableView.reloadData()
        }))
        
        present(ac, animated: true)
    }
                                                        
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Shopping", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}

