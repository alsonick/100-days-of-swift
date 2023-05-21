//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 21/05/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        loadJSON()
    }

    func loadJSON() {
        DispatchQueue.global(qos: .background).async {
            if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let countries = try decoder.decode([Country].self, from: data)
                    
                    for country in countries {
                        self.countries.append(country)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Something Went Wrong", message: error.localizedDescription, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default)
                        alert.addAction(action)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    // MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            detailViewController.name = countries[indexPath.row].name
            detailViewController.code = countries[indexPath.row].code
            detailViewController.capital = countries[indexPath.row].capital
            detailViewController.region = countries[indexPath.row].region
            detailViewController.currency = countries[indexPath.row].currency
            detailViewController.language = countries[indexPath.row].language
            detailViewController.flag = countries[indexPath.row].flag
            detailViewController.dialling_code = countries[indexPath.row].dialling_code
            detailViewController.isoCode = countries[indexPath.row].isoCode
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

