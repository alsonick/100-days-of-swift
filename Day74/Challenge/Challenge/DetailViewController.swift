//
//  DetailViewController.swift
//  Challenge
//
//  Created by Nicholas on 04/06/2023.
//

import UIKit

// Gonna have to work on fixing the bug tm

class DetailViewController: UIViewController {

    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var textView: UITextView!
    
    var notes: [Note]?
    var saved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        textView.delegate = self
        textView.text = ""
    
        let activityButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showActivitViewController))
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let notes = UIBarButtonItem(title: "\(notes?.count ?? 0) notes", style: .plain, target: self, action: nil)
        
        notes.tintColor = .black
        notes.isEnabled = false
        
        navigationItem.rightBarButtonItems = [saveButton, activityButton]
        toolbar.items = [spacer, notes, spacer]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for toolBarItem in navigationItem.rightBarButtonItems! {
            if textView.text == "" {
                toolBarItem.isEnabled = false
            }
        }
    }
    
    @objc func showActivitViewController() {
        let items = [textView.text]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @objc func cancel() {
        if !saved && textView.text! != "" {
            let alert = UIAlertController(title: "Unsaved Note", message: "Would you like to save your changes?", preferredStyle: .alert)
            
            // Cancel Action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            
            // Save Action
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
                self?.saved = true
                self?.save()
            }))
            
            present(alert, animated: true)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func save() {
        // Add note to the saved notes array
        let note = Note(content: textView.text)
        notes?.insert(note, at: 0)
        saved = true

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saved = false
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        for toolBarItem in navigationItem.rightBarButtonItems! {
            toolBarItem.isEnabled = textView.text != "" ? true : false
        }
    }
}
