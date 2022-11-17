//
//  GetAllCharactersService.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation

protocol GetAllCharactersServicable {
    func getAllCharacters() async -> Result<[CharacterInfoDataModel], RequestError>
}

final class GetAllCharactersService: HTTPClient, GetAllCharactersServicable {
    func getAllCharacters() async -> Result<[CharacterInfoDataModel], RequestError> {
        return await sendRequest(endpoint: BreakingBadEndPoint.getAllCharacters,
                                 responseModel: [CharacterInfoDataModel].self)
    }
}
