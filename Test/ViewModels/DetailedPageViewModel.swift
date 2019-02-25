//
//  DetailedPageViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

class DetailedPageViewModel {
    let apiClient: LastFmApiClient
    let coreDataService: CoreDataService
    private(set) var tracks: [TrackCellViewModel] = []
    private let albumViewModel: AlbumCellViewModel?
    private var albumInfo: AlbumInfo?
    init(apiClient: LastFmApiClient = LastFmApiClient(),
         coreDataService: CoreDataService = .shared,
        albumViewModel: AlbumCellViewModel?) {
        self.apiClient = apiClient
        self.coreDataService = coreDataService
        self.albumViewModel = albumViewModel
    }
    
    func getAlbumInfo(completionHandler: @escaping (AlbumInfo)-> Void) {
        guard let artistName = albumViewModel?.artistName,
            let albumName = albumViewModel?.albumName else {
                return
        }
        apiClient.getAlbumInfo(artistName: artistName, albumName: albumName) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albumInfo = albums.album
                self?.tracks = albums.album.tracks.track.map { TrackCellViewModel(name: $0.name)}
                completionHandler(albums.album)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func saveAlbum() {
        guard let album = albumInfo else {
            return
        }
        coreDataService.deleteAlbum(with: album.name)
    }
}
