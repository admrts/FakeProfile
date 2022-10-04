//
//  FakeProfile.swift
//  FakeProfile
//
//  Created by Ali Demirtaş on 4.10.2022.
//

import Foundation

struct FakeProfile: Codable {
    let results: [Results]
}

struct Results: Codable {
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let picture: Picture
    let location: Location
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Street
    let city: String
    let state: String
    let country: String
}

struct Street: Codable {
    let number: Int
    let name: String
}

struct Picture: Codable {
    let large: String
}
