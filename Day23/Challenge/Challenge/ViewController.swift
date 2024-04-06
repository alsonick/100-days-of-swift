//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 06/04/2024.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Challenge"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("@3x.png") {
                flags.append(item.replacingOccurrences(of: "@3x.png", with: ""))
            }
        }
    }
    
    func capitalizeLetterCountries(word: String) -> String {
        return word.count == 2 ? word.uppercased() : word
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = capitalizeLetterCountries(word: flags[indexPath.row].capitalizingFirstLetter())
        cell.imageView?.image = UIImage(named: "\(flags[indexPath.row])@3x.png")
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = "\(flags[indexPath.row])@3x.png"
            vc.countryName = capitalizeLetterCountries(word: flags[indexPath.row].capitalizingFirstLetter())
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

