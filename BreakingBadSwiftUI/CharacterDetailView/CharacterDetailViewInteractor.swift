//
//  CharacterDetailViewInteractor.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

class CharacterDetailViewInteractor: ObservableObject {
    
    var getAllQuotesService: GetAuthorQuotesServicable
    
    @Published var listAuthorQuotes: [AuthorQuotesUIModel] = []
    
    init() {
        getAllQuotesService =  GetAuthorQuoteService()
        Task {
            await fetchCharacterQuotes(authorName: "Jesse Pinkman")
        }
    }
    
    func fetchCharacterQuotes(authorName: String) async {
        let result = await getAllQuotesService.getAuthorQuotesFor(author: authorName)
        
        switch result {
        case .success(let model):
            print(model)
            await configureQuotesUIModel(modelList: model)
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
}
