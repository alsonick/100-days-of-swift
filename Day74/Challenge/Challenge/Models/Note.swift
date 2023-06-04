//
//  Note.swift
//  Challenge
//
//  Created by Nicholas on 04/06/2023.
//

import Foundation

struct Note {
    var content: String
    var id: UUID
    
    init(content: String, id: UUID = UUID()) {
        self.content = content
        self.id = id
    }
}
