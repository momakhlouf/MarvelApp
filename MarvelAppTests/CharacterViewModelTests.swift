//
//  CharacterViewModelTests.swift
//  MarvelAppTests
//
//  Created by Mohamed Makhlouf Ahmed on 29/01/2024.
//

import XCTest
import Combine
@testable import MarvelApp

final class ViewModelTests: XCTestCase {
    
    var cancellables =  Set<AnyCancellable>()
    
    func testFetchCharacters(){
        let mockCharacters = Character.mockData
        let mockCharacterDetails = CharacterDetails.mockData
        let mockService = MockService(characters: mockCharacters, characterDetails: mockCharacterDetails)
        let characterViewModel = CharacterViewModel(service: mockService )
        
        let expectation = XCTestExpectation(description: "fetch characters")
        
        characterViewModel.$state
            .sink { state in
                switch state{
                case .loaded:
                    expectation.fulfill()
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        characterViewModel.fetchCharacters()
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(characterViewModel.characters.count, 0)
        XCTAssertNotEqual(characterViewModel.characters, mockCharacters)
    }
}
