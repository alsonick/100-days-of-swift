//
//  ViewController.swift
//  Project2
//
//  Created by Nicholas on 11/04/2023.
//

import UIKit

// Finish this tm

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(displayScore))
        
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
        
        title = "\(countries[correctAnswer].uppercased()) - SCORE: \(score)"
    }
    
    func dimButtonAlpha(button sender: UIButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            sender.alpha = 1
        }
    }
    
    func prefixCountyNameCorrectly(country: String) -> String {
        let countryLowercased = country.lowercased()
        
        if countryLowercased.hasPrefix("uk") || countryLowercased.hasPrefix("us") {
            return country.uppercased()
        }
        
        return country.capitalized
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        questionsAsked += 1
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4) {
            sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            sender.transform = .identity
        }
        
        let highScore = defaults.integer(forKey: "highScore")
    
        if score > highScore {
            showAlert(title: "Congrats!", message: "New high score!", handler: nil)
        }
        
        print(highScore)
        print(score)
        
        if questionsAsked == 10 {
            showAlert(title: "Congrats!", message: "You've answered \(questionsAsked) questions.", handler: askQuestion)
            questionsAsked = 0
        }
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "Your score is \(score)"
            score += 1
        } else {
            title = "Wrong"
            message = "That's incorrect! That's the flag of \(prefixCountyNameCorrectly(country: countries[sender.tag]))."
            score -= 1
        }
        
        showAlert(title: title, message: message, handler: askQuestion)
        
        dimButtonAlpha(button: sender)
    }
    
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: handler))
        present(ac, animated: true)
    }
    
    @objc func displayScore() {
        let ac = UIActivityViewController(activityItems: ["Your current score is \(score)."], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}

