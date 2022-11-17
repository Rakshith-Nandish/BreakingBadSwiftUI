//
//  CharacterDetailViewInteractorTests.swift
//  BreakingBadSwiftUITests
//
//  Created by Rakshith on 11/17/22.
//

import XCTest
@testable import BreakingBadSwiftUI

class CharacterDetailViewInteractorTests: XCTestCase {

    var characterDetailViewInteractor: CharacterDetailViewInteractor!
    let mockedAuthorQuotes = MockedGetAuthorQuotesService()
    
    override func setUpWithError() throws {
        characterDetailViewInteractor = CharacterDetailViewInteractor(
            selectedCharacterUIModel: CharacterUIModel(id: 1, name: "Jesse Pinkman", liked: true, disliked: true), getAllQuotesService: mockedAuthorQuotes,
            getCharacterDetailService: GetCharacterDetailService())
    }

    override func tearDownWithError() throws {
    }

    func testGetCharacterQuotes() async throws {
        await characterDetailViewInteractor.fetchCharacterDetails(authorName: "Jesse Pinkman")
        XCTAssertTrue(!characterDetailViewInteractor.listAuthorQuotes.isEmpty)
        XCTAssertTrue(characterDetailViewInteractor.listAuthorQuotes.count ==  20)
    }
    
    func testGetCharacterDetail() async throws {
        await characterDetailViewInteractor.fetchCharacterDetails(authorName: "Walter White")
        XCTAssertEqual(characterDetailViewInteractor.characterName, "Walter White")
    }
}
