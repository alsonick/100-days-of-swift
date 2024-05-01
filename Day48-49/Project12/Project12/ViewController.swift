//
//  ViewController.swift
//  Project12
//
//  Created by Nicholas Njoki on 01/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(25, forKey: "Age")
        defaults.setValue(true, forKey: "UseFaceID")
        defaults.setValue(CGFloat.pi, forKey: "Pi")
        
        defaults.setValue("Paul Hudson", forKeyPath: "Name")
        defaults.setValue(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.setValue(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.setValue(dict, forKey: "SavedDictionary")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceID")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDictionary = defaults.object(forKey: "SavedDictionary") as? [String: String] ?? [String: String]()
    }


}

