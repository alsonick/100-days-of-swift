//
//  ViewController.swift
//  Project1
//
//  Created by Nicholas on 08/04/2023.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? CollectionViewCell else {
            fatalError("This should work")
        }
        
        let picture = pictures[indexPath.item]
        
        cell.label.text = picture
        
        // Adds a light gray border to the image view
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        cell.imageView.image = UIImage(named: picture)
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    //        cell.textLabel?.text = pictures[indexPath.row]
    //        return cell
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return pictures.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
    //            vc.selectedImage = pictures[indexPath.row]
    //            vc.totalNumberOfImages = pictures.count
    //            vc.selectedImagePosition = pictures.firstIndex(of: pictures[indexPath.row])
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
    //
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    @objc func recommend() {
        let ac = UIActivityViewController(activityItems: ["Recommend Storm Viewer App"], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}

