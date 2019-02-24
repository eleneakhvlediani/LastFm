//
//  AlbumsResult.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
struct AlbumsResult: Decodable {
    let topalbums: TopAlbums
}

struct TopAlbums: Decodable {
    let album: [AlbumResult]
}

struct AlbumResult: Decodable {
    struct Artist: Decodable {
        let name: String
    }
    let name: String
    let mbid: String?
    let image: [Image]
    let artist: Artist
    var imageUrl: String? {
        return image.last?.text
    }
}
