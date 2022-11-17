//
//  QuoteInfoDataModel.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation
struct QuoteInfoDataModel: Codable {
    let id: Int
    let quote: String
    let author: String
    
    private enum CodingKeys: String, CodingKey {
        case quote, author
        case id = "quote_id"
    }
}
