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
    private(set) var tracks: [TrackCellViewModel] = []
    private let albumViewModel: AlbumCellViewModel?
    init(apiClient: LastFmApiClient = LastFmApiClient(),
        albumViewModel: AlbumCellViewModel?) {
        self.apiClient = apiClient
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
                self?.tracks = albums.album.tracks.track.map { TrackCellViewModel(name: $0.name)}
                completionHandler(albums.album)
            case .failure(let error):
                print(error)
            }
        }
    }
}
