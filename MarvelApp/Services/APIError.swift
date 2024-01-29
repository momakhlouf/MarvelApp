//
//  APIError.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation

enum APIError: Error , CustomStringConvertible{
    
    case invalidURL
    case decodingError(DecodingError?)
    case badResponse(Int)
    case unknown
    
    var description: String{
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingError(let decodingError):
            return "Decoding error: \(decodingError)"
        case .badResponse(let statusCode):
            return "bad response with status code: \(statusCode) "
        case .unknown:
            return "unknown error is occurred"
        }
    }
    
    var localizedDescription: String{
        switch self {
        case .invalidURL, .unknown:
            return "Something went wrong"
        case .decodingError(let decodingError):
            return decodingError?.localizedDescription ?? "Something went wrong"
        case .badResponse(_):
            return "something went wrong"
        }
    }
    
}


