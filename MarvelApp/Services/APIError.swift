//
//  APIError.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case decodingError
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String?{
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingError :
            return "Failed to decode the object from the service"
        case .unknown:
            return "unknown error is occurred"
        }
    }
}
