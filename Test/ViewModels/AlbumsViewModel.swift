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
    var didUpdateAlbums: (() -> Void)?
    private(set) var albums = [AlbumCellViewModel]()
    var shouldHaveSearch: Bool {
        return strategy.shouldHaveSearch
    }
    init(strategy: GetAlbumStrategy) {
        self.strategy = strategy
        self.strategy.reloadHandler = { [weak self] albums in
            self?.albums = albums
            self?.didUpdateAlbums?()
        }
    }
    
    func getAlbums() {
        strategy.getAlbums()
    }
}

protocol GetAlbumStrategy: class {
    func getAlbums()
    var shouldHaveSearch: Bool { get }
    var reloadHandler: (([AlbumCellViewModel]) -> Void)? { set get }
}


class DownloadStrategy: GetAlbumStrategy, CoreDataServiceDelegate {
    var reloadHandler: (([AlbumCellViewModel]) -> Void)?
    let shouldHaveSearch: Bool = false
    let apiClient: LastFmApiClient
    let name: String
    let coreDataService: CoreDataService
    private var downloadedAlbums = [AlbumResult]()
    init(name: String,
        apiClient: LastFmApiClient = LastFmApiClient(),
        coreDataService: CoreDataService = .shared) {
        self.coreDataService = coreDataService
        self.apiClient = apiClient
        self.name = name
        self.coreDataService.addObserver(self)
    }

    func getAlbums(){
         downloadAlbums { [weak self] downloadedAlbums in
            self?.downloadedAlbums = downloadedAlbums
            self?.combineDownloadedWithSavedAlbums()
        }
    }
    
    private func combineDownloadedWithSavedAlbums() {
        let downloadedAlbums = self.downloadedAlbums
        getSavedAlbums { savedAlbums in
            let albums = downloadedAlbums.map { value -> AlbumCellViewModel in
                let isSaved = savedAlbums.contains { $0.name == value.name }
                return AlbumCellViewModel(albumName: value.name, artistName: value.artist.name, imageUrl: value.imageUrl ?? "", isSaved: isSaved)
            }
            self.reloadHandler?(albums)
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
    
    func didUpdate() {
       combineDownloadedWithSavedAlbums()
    }
}

class GetFromDataBaseStrategy: GetAlbumStrategy, CoreDataServiceDelegate {
    var reloadHandler: (([AlbumCellViewModel]) -> Void)?
    let shouldHaveSearch: Bool = true
    let coreDataService: CoreDataService
    init(coreDataService: CoreDataService = .shared) {
        self.coreDataService = coreDataService
        self.coreDataService.addObserver(self)
    }
    
    func getAlbums(){
        coreDataService.getAlbums { [weak self] savedAlbums in
            let albums = savedAlbums.map { AlbumCellViewModel(albumName: $0.name, artistName: $0.artist, imageUrl: $0.imageUrl, isSaved: true) }
            self?.reloadHandler?(albums)
        }
    }
    
    func didUpdate() {
        getAlbums()
    }
}
