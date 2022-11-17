//
//  GetAuthorQuotesService.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

protocol GetAuthorQuotesServicable {
    func getAuthorQuotesFor(author: String)  async -> Result<[QuoteInfoDataModel], RequestError>
}

class GetAuthorQuoteService: HTTPClient, GetAuthorQuotesServicable {
    func getAuthorQuotesFor(author: String) async -> Result<[QuoteInfoDataModel], RequestError> {
        return await sendRequest(endpoint: BreakingBadEndPoint.getQuotes(authorName: author),
                           responseModel: [QuoteInfoDataModel].self)
    }
}
