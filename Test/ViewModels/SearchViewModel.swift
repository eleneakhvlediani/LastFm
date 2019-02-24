//
//  SearchViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel: NSObject, UISearchBarDelegate {
    let apiClient: LastFmApiClient
    let title = "Search"
    private(set) var items = [ArtistCellViewModel]()
    private var throttler = Throttler(seconds: 0.5)
    var tableUpdated: (()->Void)?
    init(apiClient: LastFmApiClient = LastFmApiClient()) {
        self.apiClient = apiClient
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.throttle {
            DispatchQueue.main.async { [weak self] in
                self?.search(text: searchText)
            }
        }
    }
    private func search(text: String) {
        guard !text.isEmpty else {
            return
        }
        apiClient.search(for: text) { [weak self] result in
            switch result {
            case .success(let artists):
                self?.items = artists.results.artistmatches.artist.map { artist in
                    return ArtistCellViewModel(name: artist.name,
                                               id: artist.mbid,
                                               imageUrl: artist.image.last?.text ?? "",
                                               listenersInfo: "Listened by \(artist.listeners)")
                }
                self?.tableUpdated?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
