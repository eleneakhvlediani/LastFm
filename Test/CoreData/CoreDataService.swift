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
            fatalError("Unable to create realm, because of error: \(error.localizedDescription)")
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
            completionHandler()
            updateDelegates.forEach { $0.didUpdate() }
        }
    }
    
    func getAlbums(completionHandler: @escaping (([SavedAlbum])-> Void)) {
        let albums = realm.objects(SavedAlbum.self)
        completionHandler(Array(albums))
    }

    
    func deleteAlbum(with albumName: String, completionHandler: @escaping ()->Void) {
        let found = realm.objects(SavedAlbum.self).filter { $0.name == albumName }
        try? realm.write {
            realm.delete(found)
            completionHandler()
            updateDelegates.forEach { $0.didUpdate() }
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
