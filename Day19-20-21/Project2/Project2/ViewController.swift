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
    var correctAnswer = 0
    
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
    
    func askQuestion(action: UIAlertAction? = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        let buttons = [button1: 0, button2: 1, button3: 2]
        
        for button in buttons {
            button.key?.setImage(UIImage(named: countries[button.value]), for: .normal)
        }
        
        title = countries[correctAnswer].uppercased()
    }
    
    func dimButtonAlpha(button sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sender.alpha = 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
        dimButtonAlpha(button: sender)
    }
}

