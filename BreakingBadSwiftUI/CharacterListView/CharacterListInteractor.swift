//
//  CharacterListViewModel.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation

enum ListViewState {
    case begin
    case loading
    case display
    case error(errorMessage: String)
}

class CharacterListInteractor: ObservableObject {
    
    @Published var listCharacterUIModels: [CharacterUIModel] = []
    @Published var viewState: ListViewState = .begin 
    
    var getAllCharactersServicable: GetAllCharactersServicable
    
    init() {
        getAllCharactersServicable = GetAllCharactersService()
    }
    
    func viewDidLoad() {
        viewState = .loading
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
            viewState = .error(errorMessage: "Something went bad! Try again")
            print(error)
        }
    }

    
    @MainActor
    func configureUIModels(dataModelList: [CharacterInfoDataModel]) {
        viewState = .display
        listCharacterUIModels = dataModelList.map( {
            CharacterUIModel(id: $0.id, name: $0.name, liked: false, disliked: false)
        })
    }
}
