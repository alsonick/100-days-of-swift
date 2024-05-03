//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 03/05/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var caption: String?
    var image: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = caption
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let image = image {
            imageView.image = UIImage(contentsOfFile: image.path())
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
