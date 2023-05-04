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
    var tries = 0 {
        didSet {
            title = "Tries: \(tries)"
        }
    }
    var word = String()
    
    var score = 0 {
        didSet {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: #selector(displayScore))
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
        tries = word.count
    }
    
    
    @objc func displayScore() {
        let ac = UIAlertController(title: "Your Score", message: "Your current score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func check() {
        for letter in promptWord {
            if word.contains(letter) {
                usedLetters.append(letter)
            }
        }
        
        var updatedWordList = [String]()
        var updatedWord = ""
        
        for _ in 0..<word.count {
            updatedWordList.append("?")
        }
        
        for (index, character) in usedLetters.enumerated() {
            print(word)
            if word.contains(character) {
                updatedWordList[index] = String(character)
            } else {
                updatedWordList[index] = "?"
            }
        }
        
        for letter in updatedWordList {
            updatedWord += letter
        }
        
        // Wrong answer
        if updatedWord == "" {
            if score != 0 {
                score -= 1
            }
            
            let ac = UIAlertController(title: "Wrong", message: "That's incorrect.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            return
        }
        
        // Correct answer
        if updatedWord == word {
            let ac = UIAlertController(title: "Correct Answer", message: "That's correct.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            score += 1
        }
        
        wordLabel.text = updatedWord
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
        if tries == 0 {
            let ac = UIAlertController(title: "Game Over", message: "You have \(tries) left. You lost.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            nextWord()
            present(ac, animated: true)
            tries = word.count
            return
        }
        
        let ac = UIAlertController(title: "Guess Word", message: "Try guess the word.", preferredStyle: .alert)
        ac.addTextField()
        
        let guessAction = UIAlertAction(title: "Guess", style: .default) {
            [weak self, weak ac] _ in
            guard let guessedWordPrompt = ac?.textFields?[0].text else { return }
            
            if guessedWordPrompt == "" {
                return
            }
            
            self?.promptWord = guessedWordPrompt
            self?.check()
            self?.tries -= 1
        }
        
        ac.addAction(guessAction)
        present(ac, animated: true)
    }
    
}

