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

struct Character: Codable, Identifiable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    
    var image : String{
     //   if thumbnail.path.lowercased().hasPrefix("http"){
        return "\(thumbnail.path.replacingOccurrences(of: "http", with: "https")).\(thumbnail.thumbnailExtension.rawValue)"
    }
    
    static func mockCharacter()-> Character{
        Character(id: 1011334, name: "3-D Man", description: "", thumbnail: Thumbnail.init(path: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "")
    }
    
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


