//
//  Service.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation
import CommonCrypto
import Combine
#warning("to be clean service")
protocol ServiceProtocol {
    func fetch <T: Decodable>(type: T.Type , url: URL) -> AnyPublisher<T, APIError>
    func fetchCharacters() -> AnyPublisher<CharacterResponse, APIError>
    func fetchCharacters(for searchTerm: String)-> AnyPublisher<CharacterResponse , APIError>
}
class Service: ServiceProtocol{
    let baseURL = "https://gateway.marvel.com/v1/public/characters"
    let publicKey = "88100161d8a098e13a728f43c5f48e10"
    let privateKey = "5802d19474aea9a571da535398425ea945d9fa81"
    let timeStamp = String(Int(Date().timeIntervalSince1970))

    
    func characterUrl() -> String{
        let hashInput = timeStamp + privateKey + publicKey
        let hash = generateMD5Hash(string: hashInput)
        let apiKeyParam = "apikey=\(publicKey)"
        let tsParam = "ts=\(timeStamp)"
        let hashParam = "hash=\(hash)"
       // print("\(baseURL)?\(tsParam)&\(apiKeyParam)&\(hashParam)")
        return "\(baseURL)?\(tsParam)&\(apiKeyParam)&\(hashParam)"
    }
    
    
    func generateMD5Hash(string: String) -> String {
        let data = string.data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes {
            CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func fetch <T: Decodable>(type: T.Type , url: URL) -> AnyPublisher<T, APIError>{
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw APIError.unknown
                }
                return output.data
            }
            .decode(type: type.self, decoder: JSONDecoder())
            .mapError { _ in
                APIError.decodingError
            }
            .eraseToAnyPublisher()
    }

    func fetchCharacters() -> AnyPublisher<CharacterResponse, APIError>{
        guard let url = URL(string: characterUrl()) else{
            return Fail(error: APIError.unknown)
                .eraseToAnyPublisher()
        }
        print(url)
        return fetch(type: CharacterResponse.self, url: url)
    }
    
    func createSearchUrl(for searchText: String) -> URL?{
        let hashInput = timeStamp + privateKey + publicKey
        let hash = generateMD5Hash(string: hashInput)
        var component = URLComponents(string: baseURL)
        let queryItems = [URLQueryItem(name: "nameStartsWith", value: searchText),
                          // just "name" , must write full name to get data
                          URLQueryItem(name: "ts", value: timeStamp),
                          URLQueryItem(name: "apikey", value: publicKey),
                          URLQueryItem(name: "hash", value: hash)
                         ]
        
        // do not no why must add key and hash again!
        component?.queryItems = queryItems
        return component?.url
    }
    
    func fetchCharacters(for searchTerm: String) -> AnyPublisher<CharacterResponse , APIError> {
        guard let url = createSearchUrl(for: searchTerm) else{
            return Fail(error: APIError.unknown)
                .eraseToAnyPublisher()
        }
        return fetch(type: CharacterResponse.self, url: url)
            .mapError { e in
                print(e)

                return APIError.decodingError
            }
            .eraseToAnyPublisher()
    }
}

