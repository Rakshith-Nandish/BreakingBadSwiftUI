//
//  CharacterDetailViewInteractor.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

enum DetailViewState {
    case begin
    case loading
    case display
    case error(error: String)
}

class CharacterDetailViewInteractor: ObservableObject {
    
    var getAllQuotesService: GetAuthorQuotesServicable
    var getCharacterDetailService: GetCharacterDetailServicable
    
    private var selectedCharacterUIModel: CharacterUIModel
    
    @Published var listAuthorQuotes: [AuthorQuotesUIModel] = []
    @Published var characterName = ""
    @Published var characterPortrayedBy = ""
    @Published var characterImageUrl = URL(string: "")
    @Published var viewState: DetailViewState = .begin
    
    init(selectedCharacterUIModel: CharacterUIModel,
         getAllQuotesService: GetAuthorQuotesServicable,
         getCharacterDetailService: GetCharacterDetailServicable) {
        self.getAllQuotesService =  getAllQuotesService
        self.getCharacterDetailService =  getCharacterDetailService
        self.selectedCharacterUIModel = selectedCharacterUIModel
    }
    
    func viewDidLoad() {
        viewState = .loading
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
            viewState = .display
            await configureQuotesUIModel(modelList: quotesModel)
            await configureCharacterDetailUIModel(detailModel: characterDetailModel)
            
        case (.failure(let errorQuotes), .failure(let errorDetail)):
            viewState =  .error(error: "Something went wrong! Please try again")
            return
        default:
            //Display error
            viewState =  .error(error: "Something went wrong! Please try again")
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
