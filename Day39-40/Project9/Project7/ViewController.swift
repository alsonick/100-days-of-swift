//
//  ViewController.swift
//  Project7
//
//  Created by Nicholas Njoki on 16/04/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var filteredPetitions = [Petition]()
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        var urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credit", style: .plain, target: self, action: #selector(showCreditAlert))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchAlert))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func showSearchAlert() {
        let ac = UIAlertController(title: "Filter", message: "What petitions would you like to see?", preferredStyle: .alert)
        ac.addTextField()
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] action in
            
            guard let search = ac?.textFields?[0].text else { return }
            
            self?.filteredPetitions = self?.petitions.filter({ petition in
                return petition.title.lowercased().contains(search.lowercased())
            }) ?? []
            
            self?.petitions = self?.filteredPetitions ?? []
            self?.tableView.reloadData()
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(searchAction)
        
        present(ac, animated: true)
    }
    
    @objc func showCreditAlert() {
        let ac = UIAlertController(title: "Credit", message: "This data comes from the We The People APIe of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

