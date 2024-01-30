//
//  MockService.swift
//  MarvelAppTests
//
//  Created by Mohamed Makhlouf Ahmed on 30/01/2024.
//

import Foundation
@testable import MarvelApp
import Combine

class MockService: ServiceProtocol{

    let characters: [Character]
    let characterDetails: [CharacterDetails]
    
    init(characters: [Character], characterDetails: [CharacterDetails]) {
        self.characters = characters
        self.characterDetails = characterDetails
    }
    
    func fetch<T>(type: T.Type, url: URL) -> AnyPublisher<T, MarvelApp.APIError> where T : Decodable {
        return Just(characters as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<MarvelApp.CharacterResponse, MarvelApp.APIError> {
        let response = CharacterResponse(data: CharacterData(offset: 0, limit: limit, total: characters.count, count: characters.count, results: characters))
        return Just(response)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    func fetchCharacters(for searchTerm: String, page: Int, limit: Int) -> AnyPublisher<MarvelApp.CharacterResponse, MarvelApp.APIError> {
        let response = CharacterResponse(data: CharacterData(offset: 0, limit: limit, total: characters.count, count: characters.count, results: characters))
        return Just(response)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchCharacterRelatedImages(for characterID: Int, sectionType: MarvelApp.CharacterSection) -> AnyPublisher<MarvelApp.CharacterDetailsResponse, MarvelApp.APIError> {
        let response = CharacterDetailsResponse(data: CharacterDetailsData(results: characterDetails))
        return Just(response)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

