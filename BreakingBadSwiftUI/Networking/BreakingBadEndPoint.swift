//
//  BreakingBadEndPoint.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation

enum BreakingBadEndPoint {
    case getAllCharacters
    case getCharacterDetail(characterId: String)
    case getQuotes(authorName: String)
}

extension BreakingBadEndPoint: Endpoint {
    var path: String {
        switch self {
        case .getAllCharacters:
            return "/api/characters"
        case .getCharacterDetail(let characterId):
            return "/api/characters/" + characterId
        case .getQuotes:
            return "/api/quote"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllCharacters, .getCharacterDetail, .getQuotes:
            return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItem: [URLQueryItem]? {
        switch self {
        case .getAllCharacters, .getCharacterDetail:
            return nil
        case .getQuotes(let authorName):
            let splitAuthoName = authorName.split(separator: " ")
            var authoNameQuery = ""
            if !splitAuthoName.isEmpty {
                for item in splitAuthoName {
                    authoNameQuery += item
                    authoNameQuery += "+"
                }
            }
            authoNameQuery = String(authoNameQuery.dropLast())
            
            let queryTerm = "author"
            return [URLQueryItem(name: queryTerm, value: authoNameQuery)]
        }
    }
}
