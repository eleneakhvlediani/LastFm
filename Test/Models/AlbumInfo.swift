//
//  AlbumInfo.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
struct AlbumDetailedInfo: Decodable {
    let album: AlbumInfo
}

struct AlbumInfo: Decodable {
    let name: String
    let artist: String
    let image: [Image]
    let tracks: TrackList
    var imageUrl: String? {
        return image.last?.text
    }
}

struct TrackList: Decodable {
    let track: [Track]
}

struct Track: Decodable {
    let name: String
}
