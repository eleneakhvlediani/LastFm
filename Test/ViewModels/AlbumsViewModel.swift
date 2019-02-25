//
//  AlbumsViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
class AlbumsViewModel {
    let title = "Albums"
    let strategy: GetAlbumStrategy
    private(set) var albums = [AlbumCellViewModel]()
    var shouldHaveSearch: Bool {
        return strategy.shouldHaveSearch
    }
    init(strategy: GetAlbumStrategy) {
        self.strategy = strategy
    }
    
    func getAlbums(reloadDataHandler: @escaping ()->Void) {
        strategy.getAlbums { [weak self] albums in
            self?.albums = albums
            reloadDataHandler()
        }
    }
}

protocol GetAlbumStrategy {
    func getAlbums(reloadDataHandler: @escaping ([AlbumCellViewModel])->Void)
    var shouldHaveSearch: Bool { get }
}


class DownloadStrategy: GetAlbumStrategy {
    let shouldHaveSearch: Bool = false
    let apiClient: LastFmApiClient
    let name: String
    init(name: String,
        apiClient: LastFmApiClient = LastFmApiClient()) {
        self.apiClient = apiClient
        self.name = name
    }

    func getAlbums(reloadDataHandler: @escaping ([AlbumCellViewModel]) -> Void) {
        apiClient.getAlbums(for: name) { result in
            switch result {
            case .success(let albums):
                let albums = albums.topalbums.album.map { value -> AlbumCellViewModel in
                    return AlbumCellViewModel(albumName: value.name, artistName: value.artist.name, imageUrl: value.imageUrl ?? "")
                }
                reloadDataHandler(albums)
            case .failure(let error):
                print(error)
            }
        }
    }
}

class GetFromDataBaseStrategy: GetAlbumStrategy {
    let shouldHaveSearch: Bool = true
    let coreDataService: CoreDataService
    init(coreDataService: CoreDataService = .shared) {
        self.coreDataService = coreDataService
    }
    
    func getAlbums(reloadDataHandler: @escaping ([AlbumCellViewModel]) -> Void) {
        coreDataService.getAlbums { savedAlbums in
            let albums = savedAlbums.map { AlbumCellViewModel(albumName: $0.name, artistName: $0.artist, imageUrl: $0.imageUrl) }
            reloadDataHandler(albums)
        }
    }
}
