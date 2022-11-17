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
}

extension BreakingBadEndPoint: Endpoint {
    var path: String {
        switch self {
        case .getAllCharacters:
            return "/api/characters"
        case .getCharacterDetail(let characterId):
            return "/api/characters/" + characterId
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllCharacters, .getCharacterDetail:
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
        return nil
    }
}
