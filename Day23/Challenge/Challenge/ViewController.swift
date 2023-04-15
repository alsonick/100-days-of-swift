//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 15/04/2023.
//

import UIKit

class ViewController: UITableViewController {
    var countyFlags = [String]()
    var filePaths = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Challenge"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let flags = try! fm.contentsOfDirectory(atPath: path)
        
        for flag in flags {
            if flag.contains("@3x") {
                let name = flag
                    .replacingOccurrences(of: "@3x", with: "")
                    .replacingOccurrences(of: ".png", with: "")
                
                let country = improveCountryNameCharacters(country: name)
                
                countyFlags.append(country)
                filePaths.append(flag)
            }
        }
        
        print(countyFlags)
    }
    
    func improveCountryNameCharacters(country: String) -> String {
        let countryLowercased = country.lowercased()
        
        if countryLowercased.hasPrefix("uk") || countryLowercased.hasPrefix("us") {
            return country.uppercased()
        }
        
        return country.capitalized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = countyFlags[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countyFlags.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.name = countyFlags[indexPath.row]
            vc.image = filePaths[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

