//
//  LastFMApiClient.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 11/17/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

class LastFmApiClient: APIClient {
        
    init() {
        super.init(sessionManager: Alamofire.SessionManager(configuration: .default))
    }
    
    func search(for artist: String,  completion: @escaping (Result<ArtistSearchResult>) -> Void) {
        let endpoint = LastFMRequest.SearchArtists(artist: artist)
        performRequest(urlRequest: endpoint,
                       parser: { data in
                        try JSONDecoder().decode(ArtistSearchResult.self, from: data)},
                       completion: completion)
    }
    
    func getAlbums(for artistName: String,  completion: @escaping (Result<AlbumsResult>) -> Void) {
        let endpoint = LastFMRequest.GetAlbums(name: artistName)
        performRequest(urlRequest: endpoint,
                       parser: { data in
                        try JSONDecoder().decode(AlbumsResult.self, from: data)},
                       completion: completion)
    }
    
    func getAlbumInfo(artistName: String, albumName: String,  completion: @escaping (Result<AlbumDetailedInfo>) -> Void) {
        let endpoint = LastFMRequest.GetAlbumInfo(name: albumName, artist: artistName)
        performRequest(urlRequest: endpoint,
                       parser: { data in
                        try JSONDecoder().decode(AlbumDetailedInfo.self, from: data)},
                       completion: completion)
    }
}
