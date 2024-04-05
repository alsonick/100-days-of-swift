//
//  DetailViewController.swift
//  Project1
//
//  Created by Nicholas Njoki on 31/03/2024.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImagePosition: Int?
    var numberOfImagesCount: Int?
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let position = selectedImagePosition, let count = numberOfImagesCount {
            title = "Picture \(position + 1) of \(count)"
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            let vc = UIAlertController(title: "Something went wrong.", message: "This image could not be loaded.", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default))
            present(vc, animated: true)
            return
        }

        if let imageName = selectedImage {
            let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        } else {
            print("No image was found.")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
