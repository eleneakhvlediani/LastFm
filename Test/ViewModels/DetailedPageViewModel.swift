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
    private (set) lazy var isAlbumSaved: Bool  = albumViewModel?.isSaved ?? false
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
        
        switch isAlbumSaved {
        case true:
            getFromDataBase(albumName: albumName, completionHandler: completionHandler)
        case false:
            downloadAlbum(artistName: artistName, albumName: albumName, completionHandler: completionHandler)
        }
        
    }
    
    private func downloadAlbum(artistName: String, albumName: String, completionHandler: @escaping (AlbumInfo)-> Void) {
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
    
    private func getFromDataBase(albumName: String, completionHandler: @escaping (AlbumInfo)-> Void) {
        coreDataService.getAlbum(with: albumName) { [weak self] savedAlbum in
            self?.tracks = savedAlbum.tracks?.map { TrackCellViewModel(name: $0.name)} ?? []
            let album = AlbumInfo(name: savedAlbum.name, artist: savedAlbum.artist, imageUrl: savedAlbum.imageUrl, tracks: savedAlbum.tracks ?? [])
            self?.albumInfo = album
            completionHandler(album)
        }
    }
    
    func saveAlbum(completionHandler: @escaping ()->Void) {
        guard let album = albumInfo else {
            return
        }
        coreDataService.addAlbum(album: album) { [weak self] in
            self?.isAlbumSaved = true
            completionHandler()
        }
    }
    
    func deleteAlbum(completionHandler: @escaping ()->Void) {
        guard let album = albumInfo else {
            return
        }
        coreDataService.deleteAlbum(with: album.name)
        { [weak self] in
            self?.isAlbumSaved = false
            completionHandler()
        }
    }
}
