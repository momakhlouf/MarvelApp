//
//  ResultState.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 27/01/2024.
//

import Foundation

enum ResultState{
    case isLoading
    case failed(error: APIError)
    case loaded(content: [Character])
}
