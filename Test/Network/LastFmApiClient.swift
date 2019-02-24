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
        let endpoint = SearchArtistRequest.SearchArtists(artist: artist)
        performRequest(urlRequest: endpoint,
                       parser: { data in
                        try JSONDecoder().decode(ArtistSearchResult.self, from: data)},
                       completion: completion)
    }
}
