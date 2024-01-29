//
//  Section.swift
//  MarvelApp
//
//  Created by Mohamed Makhlouf Ahmed on 28/01/2024.
//

import Foundation

struct CharacterDetailsResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CharacterDetailsData
}

struct CharacterDetailsData: Codable {
    let results: [CharacterDetails]
}

struct CharacterDetails: Codable, Identifiable {
    let id: Int
    let title: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: ComicThumbnail
   // let images: [ComicThumbnail]?
    var image: String{
        return "\(thumbnail.path.replacingOccurrences(of: "http", with: "https")).\(thumbnail.thumbnailExtension.rawValue)"
    }
    
    static func mockCharacterDetails()-> CharacterDetails{
        CharacterDetails(id: 1, title: "", description: "", resourceURI: "", thumbnail: ComicThumbnail(path: "", thumbnailExtension: ComicExtension.jpg))
    }
}


// MARK: - Thumbnail
struct ComicThumbnail: Codable {
    let path: String
    let thumbnailExtension: ComicExtension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ComicExtension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    case png = "png"
    case unknown
}

  
