//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 04/06/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
    }
    
    func navigateToDetailViewController() {
        if let detailViewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            detailViewController.notes = notes
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @objc func loadNotes(notification: NSNotification) {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func addNote() {
        navigateToDetailViewController()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "New Note"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

