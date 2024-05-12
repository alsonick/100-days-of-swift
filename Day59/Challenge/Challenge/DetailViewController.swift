//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas Njoki on 12/05/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    var country: String?
    var fact: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        textView.text = fact ?? "No fact provided."
        title = country ?? "No country provided."
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
