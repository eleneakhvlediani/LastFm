//
//  AlbumsViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
class AlbumsViewModel {
    let apiClient: LastFmApiClient
    let name: String
    let title = "Albums"
    private(set) var albums = [AlbumCellViewModel]()
    init(name: String,
        apiClient: LastFmApiClient = LastFmApiClient()) {
        self.apiClient = apiClient
        self.name = name
    }
    
    func getAlbums(reloadDataHandler: @escaping ()->Void) {
        apiClient.getAlbums(for: name) { result in
            switch result {
            case .success(let albums):
                self.albums = albums.topalbums.album.map { value -> AlbumCellViewModel in
                    return AlbumCellViewModel(albumName: value.name, artistName: value.artist.name, imageUrl: value.imageUrl ?? "")
                }
                reloadDataHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
}
