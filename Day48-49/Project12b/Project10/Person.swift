//
//  Person.swift
//  Project10
//
//  Created by Nicholas Njoki on 26/04/2024.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
