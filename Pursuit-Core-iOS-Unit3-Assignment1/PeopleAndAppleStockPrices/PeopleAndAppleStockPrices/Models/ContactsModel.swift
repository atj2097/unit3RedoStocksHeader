//
//  ContactsModel.swift
//  PeopleAndAppleStockPrices
//
//  Created by God on 9/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

enum JSONError: Error {
    case decodingError(Error)
}

struct ResultsWrapper: Codable {
    let results: [Results]
}
struct Results: Codable {
    let gender: String
    let name: Name
    let email: String
    let picture: Picture
    let dob: DOB
}
struct Picture: Codable {
    let large: String
}
struct DOB: Codable {
    let age: Int
}
struct Name: Codable {
    let first: String
    let last: String
}
