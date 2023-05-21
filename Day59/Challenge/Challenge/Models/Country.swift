//
//  Country.swift
//  Challenge
//
//  Created by Nicholas on 21/05/2023.
//

import Foundation

struct Country: Decodable {
    let name: String
    let code: String?
    let capital: String
    let region: String
    let currency: Currency
    let language: Language?
    let flag: String
    let dialling_code: String
    let isoCode: String
}

struct Currency: Decodable {
    let code: String
    let name: String
}

struct Language: Decodable {
    let iso639_2: String?
    let name: String
    let nativeName: String?
}
