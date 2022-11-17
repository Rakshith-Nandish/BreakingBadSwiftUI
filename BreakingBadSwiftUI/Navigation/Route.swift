//
//  Route.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/15/22.
//

import Foundation
import SwiftUI

enum Route {
    case detail(characterUIModel: CharacterUIModel)
}


struct Navigator {
    static func navigate<T: View>(route: Route, content: () -> T) -> AnyView {
        switch route {
        case .detail(let characterUIModel):
            let getAllQuotesService = GetAuthorQuoteService()
            let getCharacterDetailService = GetCharacterDetailService()
            
            let viewInteractor = CharacterDetailViewInteractor(selectedCharacterUIModel: characterUIModel, getAllQuotesService: getAllQuotesService, getCharacterDetailService: getCharacterDetailService)
            return AnyView(
                NavigationLink(destination: CharacterDetailView(viewInteractor: viewInteractor)) {
                content()
            })
        }
    }
}
