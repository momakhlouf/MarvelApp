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

struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name, description: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let urls: [URLElement]
    var image : String{
        //   if thumbnail.path.lowercased().hasPrefix("http"){
        return "\(thumbnail.path.replacingOccurrences(of: "http", with: "https")).\(thumbnail.thumbnailExtension.rawValue)"
    }
    
    // for testing func
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.description == rhs.description
        && lhs.resourceURI == rhs.resourceURI
        && lhs.urls == rhs.urls
        && lhs.thumbnail == rhs.thumbnail
    }
    
}

struct Thumbnail: Codable, Equatable {
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
    case png = "png"
    case unknown
}

struct URLElement: Codable, Hashable{
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

extension Character{
    static var mockData: [Character] {
        [
            .init(id: 1, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.jpg), resourceURI: "", urls: []),
            .init(id: 2, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.jpg), resourceURI: "", urls: []),
            .init(id: 3, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.jpg), resourceURI: "", urls: []),
            .init(id: 4, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.jpg), resourceURI: "", urls: []),
            .init(id: 5, name: "Aaron Stack", description: "", thumbnail: Thumbnail(path: "", thumbnailExtension: Extension.jpg), resourceURI: "", urls: [])
        ]
    }
}




