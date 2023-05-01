//
//  ViewController.swift
//  Project7
//
//  Created by Nicholas on 25/04/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var filteredPetitions = [Petition]()
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = determineUrlString()
        performRequest(with: urlString)
        performSelector(inBackground: #selector(performRequest), with: nil)
    }
    
    func determineUrlString() -> String {
        let urlString: String
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showDataAlert))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterPetitions))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        return urlString
    }
    
    @objc func performRequest(with urlString: String = "https://www.hackingwithswift.com/samples/petitions-1.json") {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        //        showError()
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    @objc func filterPetitions() {
        let ac = UIAlertController(title: "Filter Petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "Filter", style: .default) { action in
            guard let filterText = ac.textFields?[0].text else { return }
            // Assume it works
            for petition in self.petitions {
                if petition.title.lowercased().contains(filterText.lowercased()) {
                    self.filteredPetitions.append(petition)
                    self.petitions = self.filteredPetitions
                    self.tableView.reloadData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(cancelAction)
        ac.addAction(filterAction)
        
        present(ac, animated: true)
    }
    
    @objc func showDataAlert() {
        let ac = UIAlertController(title: "Data Origins", message: "The data comes from 'We the people API of the white house'.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Connection Error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if petitions.count > indexPath.row {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.text = petition.body == "" ? "No body" : petition.body
            cell.accessoryType = petition.body == "" ? .none : .disclosureIndicator
        } else {
            cell.textLabel?.text = "Reset"
            cell.textLabel?.textColor = .systemBlue
            cell.accessoryType = .none
            cell.detailTextLabel?.text = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        if petitions.count > indexPath.row {
            vc.detailItem = petitions[indexPath.row]
            if petitions[indexPath.row].body != "" {
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let ac = UIAlertController(title: "No body content for: '\(petitions[indexPath.row].title)' petition.", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
        } else {
            let urlString = determineUrlString()
            performRequest(with: urlString)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

