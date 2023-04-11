//
//  ViewController.swift
//  Project2
//
//  Created by Nicholas on 11/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        let buttons = [button1, button2, button3]
        
        for button in buttons {
            if let button = button {
                addBorderToButton(button)
            }
        }
        
        askQuestion()
    }
    
    func addBorderToButton(_ button: UIButton) {
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
    }
    
    func askQuestion() {
        let buttons = [button1, button2, button3]
        
        for button in buttons {
            button?.setImage(UIImage(named: countries.randomElement() ?? "us"), for: .normal)
        }
    }
}

