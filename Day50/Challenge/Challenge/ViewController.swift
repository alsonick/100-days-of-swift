//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 12/05/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        title = "Photos"
    }
    
    @objc func addPhoto() {
        let picker = UIImagePickerController()
        
        // Configure picker
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        // Present the picker
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func showAddCaptionAlert(image: UIImage) {
        let alert = UIAlertController(title: "Add Caption", message: "Add a caption for this image.", preferredStyle: .alert)
        alert.addTextField()
        
        let action = UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
            guard let caption = alert?.textFields?[0].text else { return }
            
            // Check if the caption input is empty
            if caption.isEmpty {
                let error = UIAlertController(title: "Empty Caption", message: "You cannot add empty captions.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                error.addAction(action)
                self?.present(error, animated: true)
                return
            }
            
            // Create the photo
            let photo = Photo(caption: caption, image: image)
            
            // Add the created photo to the photos list
            self?.photos.append(photo)
            
            // Reload the table view
            self?.tableView.reloadData()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Table View Data Source Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Customize the cell
        cell.textLabel?.text = photos[indexPath.row].caption
        cell.imageView?.image = photos[indexPath.row].image
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    // MARK: - Table View Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.image = photos[indexPath.row].image
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let name = UUID().uuidString
        let path = getDocumentsDirectory().appendingPathComponent(name)
        
        if let jpeg = image.jpegData(compressionQuality: 0.9) {
            try? jpeg.write(to: path)
        }
        
        dismiss(animated: true)
        
        showAddCaptionAlert(image: image)
    }
}

// MARK: - UINavigationControllerDelegate

extension ViewController: UINavigationControllerDelegate {
}
