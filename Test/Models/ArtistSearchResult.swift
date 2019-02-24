//
//  ArtistSearchResult.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

struct ArtistSearchResult: Decodable {
    let results: ArtistResult
}

struct ArtistResult: Decodable {
    let artistmatches: Artists
}

struct Artists: Decodable {
    let artist: [Artist]
}

struct Artist: Decodable {
    let name: String
    let listeners: String
    let mbid: String
    let url: String
    let streamable: String
    let image: [Image]
}

struct Image: Decodable {
    let text: String
    let size: String
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size = "size"
    }
}
