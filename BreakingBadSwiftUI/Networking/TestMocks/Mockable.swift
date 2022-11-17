//
//  Mockable.swift
//  BreakingBadSwiftUI
//
//  Created by Rakshith on 11/17/22.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    
    func loadJSON<T: Codable>(filename: String, type: T.Type) -> T?
}

extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Codable>(filename: String, type: T.Type) -> T? {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                return decodedResponse
            }
        } catch {
            return nil
            fatalError("Failed to decode loaded JSON")
        }
        return nil
    }
}
