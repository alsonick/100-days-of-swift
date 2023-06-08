//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 04/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        let notes = UIBarButtonItem(title: "\(notes.count) notes", style: .plain, target: self, action: nil)
        
        notes.tintColor = .black
        notes.isEnabled = false
        
        toolbar.items = [spacer, notes, spacer, compose]
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name(rawValue: "load"), object: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Notes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(notes)
    }
    
    func navigateToDetailViewController() {
        if let detailViewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            detailViewController.notes = notes
//            navigationController?.pushViewController(detailViewController, animated: true)
            present(detailViewController, animated: true)
        }
    }
    
    @objc func loadNotes(notification: NSNotification) {
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func addNote() {
        navigateToDetailViewController()
    }

    

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "New Note"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
}
