//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 06/04/2024.
//

import UIKit

extension UIImage {
    func withBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let borderWidth = width * scale
        let borderRect = CGRect(x: 0, y: 0, width: size.width + borderWidth * 2, height: size.height + borderWidth * 2)

        UIGraphicsBeginImageContextWithOptions(borderRect.size, false, 0.0)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(borderWidth)
        let borderPath = UIBezierPath(rect: borderRect)
        context?.addPath(borderPath.cgPath)
        context?.drawPath(using: .stroke)

        let imageRect = CGRect(x: borderWidth, y: borderWidth, width: size.width, height: size.height)
        draw(in: imageRect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var countryName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = countryName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self, action: #selector(shareTapped)
        )
        navigationItem.largeTitleDisplayMode = .never

        if let image = selectedImage {
            imageView.image = UIImage(named: image)?.withBorder(width: 0.1, color: .gray)
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
        guard let image = imageView.image?.jpegData(compressionQuality: 0.9) else {
            let vc = UIAlertController(title: "Something went wrong.", message: "This image could not be loaded", preferredStyle: .alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default))
            present(vc, animated: true)
            return
        }
        
        if let country = countryName {
            let vc = UIActivityViewController(activityItems: [image, "Share the \(country) flag with friends."], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        } else {
            print("No country name was provided.")
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
