//
//  CoreDataService.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import RealmSwift

class CoreDataService {
    static let shared = CoreDataService()
    private var updateDelegates = [CoreDataServiceDelegate]()
    let realm: Realm
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError()
        }
    }
    
    func addAlbum(album: AlbumInfo, completionHandler: @escaping ()->Void) {
        let albumContext = SavedAlbum()
        albumContext.name = album.name
        albumContext.artist = album.artist
        albumContext.imageUrl = album.imageUrl
        album.tracks.track.forEach { track in
            let savedTrack = TrackRealm()
            savedTrack.name = track.name
            albumContext.tracks.append(savedTrack)
        }
        try? realm.write {
            realm.add(albumContext)
            save(completionHandler: completionHandler)
        }
    }
    
    func getAlbums(completionHandler: @escaping (([SavedAlbum])-> Void)) {
        let albums = realm.objects(SavedAlbum.self)
        var savedAlbum = [SavedAlbum]()
        albums.forEach { saved in
            savedAlbum.append(saved)
        }
        completionHandler(savedAlbum)
    }
    
    private func save(completionHandler: @escaping ()->Void) {
        completionHandler()
        updateDelegates.forEach { $0.didUpdate() }
    }
    
    func deleteAlbum(with albumName: String, completionHandler: @escaping ()->Void) {
        let found = realm.objects(SavedAlbum.self).filter { $0.name == albumName }
        try? realm.write {
            realm.delete(found)
            save(completionHandler: completionHandler)
        }
    }
    
    func getAlbum(with albumName: String, completionHandler: @escaping (SavedAlbum)->Void) {
        let found = realm.objects(SavedAlbum.self).filter { $0.name == albumName }
        if let firstFoundAlbum = found.first {
            completionHandler(firstFoundAlbum)
        }
    }

    func addObserver<T: CoreDataServiceDelegate>(_ observer: T) {
        updateDelegates.append(WeakRef(value: observer))
    }
}
