//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 12/05/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    let url = "https://notnick.io/sample/data/countries.json"
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source", style: .plain, target: self, action: #selector(showSourceAlert))
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            // I'm only doing this to get rid of the xcode error.
            if let url = URL(string: self?.url ?? "https://notnick.io/sample/data/countries.json") {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                }
            }
        }
    }
    
    @objc func showSourceAlert() {
        let sourceAlert = UIAlertController(title: "Source", message: url, preferredStyle: .alert)
        sourceAlert.addAction(UIAlertAction(title: "OK", style: .default))
        present(sourceAlert, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let response = try? decoder.decode(Response.self, from: json) {
            self.countries = response.countries
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.detailTextLabel?.text = countries[indexPath.row].fact
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.country = countries[indexPath.row].name
            detailViewController.fact = countries[indexPath.row].fact
            navigationController?.pushViewController(detailViewController, animated: true)
        }
            
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

