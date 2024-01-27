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
    
    func createUrl( searchText: String? = nil ,page: Int?, limit: Int?) -> URL?{
        let hash = generateMD5Hash(string: timeStamp + privateKey + publicKey)
        var queryItems = [URLQueryItem(name: "ts", value: timeStamp),
                          URLQueryItem(name: "apikey", value: publicKey),
                          URLQueryItem(name: "hash", value: hash)]
        if let searchText = searchText {
            queryItems.append(URLQueryItem(name: "nameStartsWith", value: searchText))
        }
        if let page = page , let limit = limit {
            let offset = page * limit
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        var component = URLComponents(string: baseURL)
        component?.queryItems = queryItems
        
        return component?.url
        //https: //gateway.marvel.com/v1/public/characters?ts=ts&apikey=apikey&hash=hash&limit=20&offset=0
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
}

//MARK: - Fetch list of all characters
extension Service{
    func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<CharacterResponse, APIError>{
        guard let url = createUrl(page: page, limit: limit)else{
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        return fetch(type: CharacterResponse.self, url: url)
    }
}

//MARK: - search services
extension Service{
    func fetchCharacters(for searchTerm: String, page: Int, limit: Int) -> AnyPublisher<CharacterResponse , APIError> {
        guard let url = createUrl(searchText: searchTerm, page: page, limit: limit)else{
            return Fail(error: APIError.unknown)
                .eraseToAnyPublisher()
        }
        return fetch(type: CharacterResponse.self, url: url)
            .mapError { _ in
                return APIError.decodingError
            }
            .eraseToAnyPublisher()
    }
}





/*
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
 func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<CharacterResponse, APIError>
 func fetchCharacters(for searchTerm: String, page: Int, limit: Int)-> AnyPublisher<CharacterResponse , APIError>
 }
 class Service: ServiceProtocol{
 let baseURL = "https://gateway.marvel.com/v1/public/characters"
 let publicKey = Config.publicKey
 let privateKey = Config.privateKey
 let timeStamp = String(Int(Date().timeIntervalSince1970))
 
 
 func generateMD5Hash(string: String) -> String {
 let data = string.data(using: .utf8)!
 var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
 _ = data.withUnsafeBytes {
 CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
 }
 return digest.map { String(format: "%02hhx", $0) }.joined()
 }
 
 func characterUrl(page: Int?, limit: Int?) -> URL?{
 let hashInput = timeStamp + privateKey + publicKey
 let hash = generateMD5Hash(string: hashInput)
 
 var queryItems = [URLQueryItem(name: "ts", value: timeStamp),
 URLQueryItem(name: "apikey", value: publicKey),
 URLQueryItem(name: "hash", value: hash)]
 if let page = page , let limit = limit {
 let offset = page * limit
 queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
 queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
 }
 
 var component = URLComponents(string: baseURL)
 component?.queryItems = queryItems
 
 return component?.url
 //https: //gateway.marvel.com/v1/public/characters?ts=ts&apikey=apikey&hash=hash&limit=20&offset=0
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
 
 func fetchCharacters(page: Int, limit: Int) -> AnyPublisher<CharacterResponse, APIError>{
 guard let url = characterUrl(page: page, limit: limit) else{
 return Fail(error: APIError.invalidURL)
 .eraseToAnyPublisher()
 }
 return fetch(type: CharacterResponse.self, url: url)
 }
 }
 
 
 
 //MARK: - search services
 extension Service{
 func createSearchUrl(for searchText: String , page: Int?, limit: Int?) -> URL?{
 let hashInput = timeStamp + privateKey + publicKey
 let hash = generateMD5Hash(string: hashInput)
 var queryItems = [URLQueryItem(name: "nameStartsWith", value: searchText),
 // just "name" , must write full name to get data
 URLQueryItem(name: "ts", value: timeStamp),
 URLQueryItem(name: "apikey", value: publicKey),
 URLQueryItem(name: "hash", value: hash)
 ]
 
 if let page = page , let limit = limit {
 let offset = page * limit
 queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
 queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
 }
 
 var component = URLComponents(string: baseURL)
 component?.queryItems = queryItems
 
 return component?.url
 }
 
 func fetchCharacters(for searchTerm: String, page: Int, limit: Int) -> AnyPublisher<CharacterResponse , APIError> {
 guard let url = createSearchUrl(for: searchTerm, page: page, limit: limit) else{
 return Fail(error: APIError.unknown)
 .eraseToAnyPublisher()
 }
 return fetch(type: CharacterResponse.self, url: url)
 .mapError { _ in
 return APIError.decodingError
 }
 .eraseToAnyPublisher()
 }
 }
 
 
 
 
 
 */
