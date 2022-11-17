//
//  CharacterDetailViewInteractor.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

class CharacterDetailViewInteractor: ObservableObject {
    
    var getAllQuotesService: GetAuthorQuotesServicable
    var getCharacterDetailService: GetCharacterDetailServicable
    
    private var selectedCharacterUIModel: CharacterUIModel
    
    @Published var listAuthorQuotes: [AuthorQuotesUIModel] = []
    @Published var characterName = ""
    @Published var characterPortrayedBy = ""
    @Published var characterImageUrl = URL(string: "")
    
    init(selectedCharacterUIModel: CharacterUIModel,
         getAllQuotesService: GetAuthorQuotesServicable,
         getCharacterDetailService: GetCharacterDetailServicable) {
        self.getAllQuotesService =  getAllQuotesService
        self.getCharacterDetailService =  getCharacterDetailService
        self.selectedCharacterUIModel = selectedCharacterUIModel
    }
    
    func viewDidLoad() {
        Task {
            await fetchCharacterDetails(authorName: selectedCharacterUIModel.name)
        }
    }

    func fetchCharacterDetails(authorName: String) async {
        async let resultQuotes = getAllQuotesService.getAuthorQuotesFor(author: authorName)
        
        async let resultCharactertDetails = getCharacterDetailService.getCharacterDetailFor(
            id: String(selectedCharacterUIModel.id))
        
        let result = await (quotes: resultQuotes, characterDetail: resultCharactertDetails)
        
        switch (result.quotes, result.characterDetail) {
        case (.success(let quotesModel), .success(let characterDetailModel)):
            await configureQuotesUIModel(modelList: quotesModel)
            await configureCharacterDetailUIModel(detailModel: characterDetailModel)
            
        case (.failure(let errorQuotes), .failure(let errorDetail)):
            return
        default:
            //Display error
            return
        }
    }
    
    @MainActor
    func configureQuotesUIModel(modelList: [QuoteInfoDataModel]) {
        listAuthorQuotes = modelList.map( {
            AuthorQuotesUIModel(id: $0.id, quote: $0.quote)
        })
    }
    
    @MainActor
    func configureCharacterDetailUIModel(detailModel: [CharacterInfoDataModel]) {
        characterName = detailModel.first?.name ?? ""
        characterPortrayedBy =  "Portrayed by: " + (detailModel.first?.portrayed ?? "")
        characterImageUrl = URL(string: detailModel.first?.img ?? "")
    }
}
