//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas on 15/04/2023.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var image: String?
    var name: String?

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))

        if let imageToLoad = image, let titleToLoad = name {
            imageView.image = UIImage(named: imageToLoad)
            title = titleToLoad
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
    
    @objc func share() {
        guard let img = imageView.image?.jpegData(compressionQuality: 0.9) else {
            let alert = UIAlertController(title: "Error Loading Image", message: "Couldn't load this image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
    
        guard let name = name else { return }
        
        let ac = UIActivityViewController(activityItems: [img, "Share the \(name) flag."], applicationActivities: [])
        ac.navigationItem.rightBarButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
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
