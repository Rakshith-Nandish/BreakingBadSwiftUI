//
//  CharacterDetailDataModel.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation
struct CharacterDetailDataModel: Codable {
    let id: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: String
    let bcsAppearance: [Int]
    
    private enum CodingKeys: String,CodingKey {
        case id = "char_id"
        case bcsAppearance = "better_call_saul_appearance"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
    }
}
