//
//  LastFmRequest.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 11/17/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

struct LastFMRequest {
    struct SearchArtists: APIEndpoint {
        let baseURLString: String = "http://ws.audioscrobbler.com/2.0"
        let artist: String
        let method: HTTPMethod = .get
        var parameters: [String : Any] {
            return ["method": "artist.search",
                    "artist": artist,
                    "api_key": apiKey,
                    "format": "json"]
        }
        var path: String {
            return ""
        }
    }
    
    struct GetAlbums: APIEndpoint {
        let baseURLString: String = "http://ws.audioscrobbler.com/2.0"
        let name: String
        let method: HTTPMethod = .get
        var parameters: [String : Any] {
            return ["method": "artist.gettopalbums",
                    "artist": name,
                    "api_key": apiKey,
                    "format": "json"]
        }
        var path: String {
            return ""
        }
    }
    
    struct GetAlbumInfo: APIEndpoint {
        let baseURLString: String = "http://ws.audioscrobbler.com/2.0"
        let name: String
        let artist: String
        let method: HTTPMethod = .get
        var parameters: [String : Any] {
            return ["method": "album.getinfo",
                    "artist": artist,
                    "album": name,
                    "api_key": apiKey,
                    "format": "json"]
        }
        var path: String {
            return ""
        }
    }
}
