//
//  CharacterListViewModel.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    
    @Published var listCharacterUIModels: [CharacterUIModel] = []
    
    var getAllCharactersServicable: GetAllCharactersServicable
    
    init() {
        getAllCharactersServicable = GetAllCharactersService()
        
        Task {
            await fetchAllCharacters()
        }
    }
    
    func fetchAllCharacters() async {
        let result = await getAllCharactersServicable.getAllCharacters()
        
        switch result {
        case .success(let model):
            await configureUIModels(dataModelList: model)
        case .failure(let error):
            print(error)
        }
    }
    
    @MainActor
    func configureUIModels(dataModelList: [CharacterInfoDataModel]) {
        listCharacterUIModels = dataModelList.map( {
            CharacterUIModel(id: $0.id, name: $0.name, liked: false, disliked: false)
        })
    }
}
