//
//  ViewController.swift
//  Challenge
//
//  Created by Nicholas on 03/05/2023.
//

import UIKit

// Complete the rest tommorow

class ViewController: UIViewController {
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var wordLengthLabel: UILabel!
    
    var usedLetters = [Character]()
    var words = [String]()
    var promptWord = ""
    var word = String()
    
    var score = 0 {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: nil, action: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let word = try? String(contentsOf: url) {
                words = word.components(separatedBy: "\n")
            }
        }
        
        nextWord()
        score = 0
        
    }
    
    func check(word: String) {
        for letter in word {
            if promptWord.contains(letter) {
                usedLetters.append(letter)
            }
        }
    }
    
    func nextWord() {
        word = words.randomElement()!
        var questionMarkWord = "?"
        for _ in 1..<word.count {
            questionMarkWord += "?"
        }
        wordLengthLabel.text = "\(word.count) characters."
        wordLabel.text = questionMarkWord
        print(word)
    }


    @IBAction func guessPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Guess Word", message: "Try guess the word.", preferredStyle: .alert)
        ac.addTextField()
        
        let guessAction = UIAlertAction(title: "Guess", style: .default) {
            [weak self, weak ac] _ in
            guard let guessedWordPrompt = ac?.textFields?[0].text else { return }
            self?.promptWord = guessedWordPrompt
        }
        
        ac.addAction(guessAction)
        present(ac, animated: true)
    }
    
}

