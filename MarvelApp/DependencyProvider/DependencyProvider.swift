//
//  DependencyProvider.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation

class DependencyProvider{
    static var service: ServiceProtocol{
        return Service()
    }
    
    static var characterViewModel: CharacterViewModel{
        return CharacterViewModel(service: service)
    }
    
    static var searchViewModel: SearchViewModel{
        return SearchViewModel(service: service)
    }
}
