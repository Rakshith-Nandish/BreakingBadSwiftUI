//
//  MockServices.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

final class MockedGetAuthorQuotesService: GetAuthorQuotesServicable, Mockable {
    func getAuthorQuotesFor(author: String) async -> Result<[QuoteInfoDataModel], RequestError> {
        let result = loadJSON(filename: "GetAuthorQuotes", type: [QuoteInfoDataModel].self)
        if let result = result {
            return .success(result)
        }
        return .failure(.invalidURL)
    }
}

final class MockedGetCharacterDetailService: GetCharacterDetailServicable, Mockable {
    func getCharacterDetailFor(id: String) async -> Result<[CharacterInfoDataModel], RequestError> {
        let result = loadJSON(filename: "GetCharacterDetail", type: [CharacterInfoDataModel].self)
        if let result = result {
            return .success(result)
        }
        return .failure(.invalidURL)
    }
}
