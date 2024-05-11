//
//  ViewController.swift
//  Project2
//
//  Created by Nicholas Njoki on 02/04/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var questionsAnswered = 0
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia","france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(shareScoreTapped))
        
        drawButtonBorder(for: button1)
        drawButtonBorder(for: button2)
        drawButtonBorder(for: button3)
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        for button in [button1, button2, button3] {
            button?.transform = .identity
        }
        
        title = "\(countries[correctAnswer].uppercased()) / \(score)"
    }
    
    func drawButtonBorder(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        questionsAnswered += 1
        
        score = sender.tag == correctAnswer ? score + 1 : score - 1
        title = sender.tag == correctAnswer ? "Correct" : "Wrong"
        
        if questionsAnswered == 10 {
            let ac = UIAlertController(title: "Congrats!", message: "You've answered \(questionsAnswered) questions.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        }
        
        // Button animation
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
        }

        
        // They got the wrong answer
        if sender.tag != correctAnswer {
            let ac = UIAlertController(title: "Wrong Flag", message: "You selected the \(countries[sender.tag]) flag.This is not the \(countries[correctAnswer]) flag.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
            return
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    @objc func shareScoreTapped() {
        let vc = UIAlertController(title: "Score", message: "Your current score is \(score).", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default))
        present(vc, animated: true)
    }
    
}

