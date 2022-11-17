//
//  GetCharacterDetailService.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation

protocol GetCharacterDetailServicable {
    func getCharacterDetailFor(id: String) async -> Result<[CharacterInfoDataModel], RequestError>
}

class GetCharacterDetailService: HTTPClient, GetCharacterDetailServicable {
    func getCharacterDetailFor(id: String) async -> Result<[CharacterInfoDataModel], RequestError> {
        return await sendRequest(endpoint: BreakingBadEndPoint.getCharacterDetail(characterId: id),
                           responseModel: [CharacterInfoDataModel].self)
    }
}
