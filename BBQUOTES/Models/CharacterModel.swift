//
//  CharacterModel.swift
//  BBQuotes
//
//  Created by Vishwas Sharma on 18/03/24.
//

import Foundation

struct CharacterModel: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}

