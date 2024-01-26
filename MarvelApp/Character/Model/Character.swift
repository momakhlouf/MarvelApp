//
//  Character.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 26/01/2024.
//

import Foundation

struct CharacterResponse: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
