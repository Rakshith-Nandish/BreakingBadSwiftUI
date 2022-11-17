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
    
    @Published var listAuthorQuotes: [AuthorQuotesUIModel] = []
    @Published var characterName = ""
    @Published var characterPortrayedBy = ""
    @Published var characterImageUrl = URL(string: "")
    
    init() {
        getAllQuotesService =  GetAuthorQuoteService()
        getCharacterDetailService =  GetCharacterDetailService()
        
        Task {
            await fetchAllDetails(authorName: "Jesse Pinkman")
        }
    }
    
    func fetchAllDetails(authorName: String) async {
        async let resultQuotes = getAllQuotesService.getAuthorQuotesFor(author: authorName)
        
        async let resultCharactertDetails = getCharacterDetailService.getCharacterDetailFor(id: String(1))
        
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
    
    func fetchCharacterQuotes(authorName: String) async {
        let result = await getCharacterDetailService.getCharacterDetailFor(id: String(1))
        
        switch result {
        case .success(let model):
            print(model)
        case .failure(let error):
            print(error)
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
