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
    let coreDataService: CoreDataService
    init(name: String,
        apiClient: LastFmApiClient = LastFmApiClient(),
        coreDataService: CoreDataService = .shared) {
        self.coreDataService = coreDataService
        self.apiClient = apiClient
        self.name = name
    }

    func getAlbums(reloadDataHandler: @escaping ([AlbumCellViewModel]) -> Void) {
        getSavedAlbums { [weak self] savedAlbums in
            self?.downloadAlbums { downloadedAlbums in
                let albums = downloadedAlbums.map { value -> AlbumCellViewModel in
                    let isSaved = savedAlbums.contains { $0.name == value.name }
                    return AlbumCellViewModel(albumName: value.name, artistName: value.artist.name, imageUrl: value.imageUrl ?? "", isSaved: isSaved)
                }
                reloadDataHandler(albums)
            }
        }
    }
    
    private func downloadAlbums(completionHandler: @escaping ([AlbumResult]) -> Void) {
        apiClient.getAlbums(for: name) { result in
            switch result {
            case .success(let albums):
                completionHandler(albums.topalbums.album)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getSavedAlbums(completionHandler: @escaping ([SavedAlbum]) -> Void) {
        coreDataService.getAlbums { savedAlbums in
            completionHandler(savedAlbums)
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
            let albums = savedAlbums.map { AlbumCellViewModel(albumName: $0.name, artistName: $0.artist, imageUrl: $0.imageUrl, isSaved: true) }
            reloadDataHandler(albums)
        }
    }
}
