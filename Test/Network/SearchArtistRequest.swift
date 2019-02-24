//
//  SearchArtistRequest.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 11/17/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

struct SearchArtistRequest {
    struct SearchArtists: APIEndpoint {
        let baseURLString: String = "http://ws.audioscrobbler.com/2.0"
        let artist: String
//        let limit: Int?
//        let page: Int?
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
}
