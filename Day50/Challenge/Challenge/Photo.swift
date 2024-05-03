//
//  Photo.swift
//  Challenge
//
//  Created by Nicholas Njoki on 03/05/2024.
//

import Foundation

class Photo: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
