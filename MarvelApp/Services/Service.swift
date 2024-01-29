//
//  Service.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation
import CommonCrypto
import Combine

protocol ServiceProtocol {
    func fetch <T: Decodable>(type: T.Type , url: URL) -> AnyPublisher<T, APIError>
    func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<CharacterResponse, APIError>
    func fetchCharacters(for searchTerm: String, page: Int, limit: Int)-> AnyPublisher<CharacterResponse , APIError>
    func fetchCharacterRelatedImages(for characterID: Int, sectionType: CharacterSection) -> AnyPublisher<CharacterDetailsResponse, APIError>
}
class Service: ServiceProtocol{
    private let baseURL: String
    private let publicKey: String
    private let privateKey: String
    private let timeStamp: String
    
    init(baseURL: String, publicKey: String, privateKey: String, timeStamp: String) {
        self.baseURL = baseURL
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.timeStamp = timeStamp
    }
    // search for it
    func generateMD5Hash(string: String) -> String {
        let data = string.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func createUrl( searchText: String? = nil ,page: Int? = nil, limit: Int? = nil, characterID: Int? = nil , sectionType : CharacterSection? = nil) -> URL?{
        let hash = generateMD5Hash(string: timeStamp + privateKey + publicKey)
        var components = URLComponents(string: baseURL)
        let path = "/v1/public/characters"
        components?.path = path
        var queryItems = [URLQueryItem(name: "ts", value: timeStamp),
                          URLQueryItem(name: "apikey", value: publicKey),
                          URLQueryItem(name: "hash", value: hash)]
        if let searchText = searchText {
            queryItems.append(URLQueryItem(name: "nameStartsWith", value: searchText))
        }
        
        
        if let sectionType = sectionType{
            switch sectionType {
            case .comics:
                if let characterID = characterID{
                    components?.path = "/v1/public/characters/\(characterID)/comics"
                }
            case .events:
                if let characterID = characterID{
                    components?.path = "/v1/public/characters/\(characterID)/events"
                }
            case .series:
                if let characterID = characterID{
                    components?.path = "/v1/public/characters/\(characterID)/series"
                }
            }
        }
        if let page = page , let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        components?.queryItems = queryItems
        return components?.url
        //https: //gateway.marvel.com/v1/public/characters?ts=ts&apikey=apikey&hash=hash&limit=20&offset=0
    }
    
    func fetch <T: Decodable>(type: T.Type , url: URL) -> AnyPublisher<T, APIError>{
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw APIError.unknown //badResponse(response.statusCode)
                }
                return output.data
            }
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError { error in
                APIError.decodingError(error as? DecodingError)
            }
            .eraseToAnyPublisher()
    }
    //MARK: - Fetch list of all characters
    func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<CharacterResponse, APIError>{
        guard let url = createUrl(page: page, limit: limit)else{
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        return fetch(type: CharacterResponse.self, url: url)
    }
    //MARK: - search services
    func fetchCharacters(for searchTerm: String, page: Int, limit: Int) -> AnyPublisher<CharacterResponse , APIError> {
        guard let url = createUrl(searchText: searchTerm, page: page, limit: limit)else{
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        return fetch(type: CharacterResponse.self, url: url)
            .mapError { _ in
                return APIError.unknown
            }
            .eraseToAnyPublisher()
    }
}

//MARK: - character comics, series and events

extension Service{
    func fetchCharacterRelatedImages(for characterID: Int, sectionType: CharacterSection) -> AnyPublisher<CharacterDetailsResponse, APIError>{
        guard let url = createUrl(characterID: characterID ,sectionType: sectionType)else{
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
            return fetch(type: CharacterDetailsResponse.self, url: url)
    }
}
