//
//  DependencyProvider.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation

class DependencyProvider{
    
   static let baseURL = "https://gateway.marvel.com/v1/public/characters"
   static let publicKey = Config.publicKey
   static let privateKey = Config.privateKey
   static let timeStamp = String(Int(Date().timeIntervalSince1970))
    
    static var service: ServiceProtocol{
        return Service(baseURL: baseURL, publicKey: publicKey, privateKey: privateKey, timeStamp: timeStamp)
    }
    
    static var characterViewModel: CharacterViewModel{
        return CharacterViewModel(service: service)
    }
    
    static var searchViewModel: SearchViewModel{
        return SearchViewModel(service: service)
    }
}
