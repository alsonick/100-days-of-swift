//
//  ViewController.swift
//  Project1
//
//  Created by Nicholas on 08/04/2023.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommend))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        
        pictures = pictures.sorted()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        let viewed = defaults.integer(forKey: "viewed\(indexPath.row)")
        cell.detailTextLabel?.text = "Viewed \(viewed) times"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.totalNumberOfImages = pictures.count
            vc.selectedImagePosition = pictures.firstIndex(of: pictures[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
        
        var viewed = defaults.integer(forKey: "viewed\(indexPath.row)")
        viewed += 1
        defaults.setValue(viewed, forKey: "viewed\(indexPath.row)")
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func recommend() {
        let ac = UIActivityViewController(activityItems: ["Recommend Storm Viewer App"], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}

