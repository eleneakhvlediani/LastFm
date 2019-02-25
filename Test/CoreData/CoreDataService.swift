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

class CoreDataService {
    static let shared = CoreDataService()
    private let context: NSManagedObjectContext
    init(persistentContainer: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer) {
        guard let container = persistentContainer else {
            fatalError("Container must not be nil")
        }
        context = container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func addAlbum(album: AlbumInfo, completionHandler: @escaping ()->Void) {
        let albumContext = Album(context: context)
        albumContext.name = album.name
        albumContext.artistName = album.artist
        albumContext.imageUrl = album.imageUrl
        album.tracks.track.forEach { track in
            let savedTrack = SavedTrack(context: context)
            savedTrack.name = track.name
            albumContext.addToTracks(savedTrack)
        }
        save(completionHandler: completionHandler)
    }
    
    func getAlbums(completionHandler: @escaping (([SavedAlbum])-> Void)) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.album.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            guard let contextArray = (result as? [NSManagedObject]) else {
                return
            }
            let savedAlbums = contextArray
                .compactMap {
                    return $0 as? Album
                }
                .map { fetched -> SavedAlbum in
                    let tracks = (fetched.tracks?.allObjects as? [SavedTrack])?.compactMap { Track(name: $0.name ?? "") }
                    return SavedAlbum(name: fetched.name ?? "", artist: fetched.artistName ?? "", imageUrl: fetched.imageUrl ?? "", tracks: tracks)
                }
            completionHandler(savedAlbums)
        } catch {
            print("Failed")
        }
    }
    
    private func save(completionHandler: @escaping ()->Void) {
        do {
            try context.save()
            completionHandler()
        } catch {
            print("Failed saving")
        }
    }
    
    func deleteAlbum(with albumName: String, completionHandler: @escaping ()->Void) {
        getSavedAlbums(with: albumName) { [weak self] contextArray in
            contextArray.forEach { obj in
                self?.context.delete(obj)
            }
            self?.save(completionHandler: completionHandler)
        }
    }
    
    func getAlbum(with albumName: String, completionHandler: @escaping (SavedAlbum)->Void) {
        getSavedAlbums(with: albumName) { contextArray in
            if let album = contextArray.first as? Album {
                let tracks = (album.tracks?.allObjects as? [SavedTrack])?.compactMap { Track(name: $0.name ?? "") }
                let saved = SavedAlbum(name: album.name ?? "", artist: album.artistName ?? "", imageUrl: album.imageUrl ?? "", tracks: tracks)
                completionHandler(saved)
            }
        }
    }

    private func getSavedAlbums(with albumName: String, completionHandler: @escaping ([NSManagedObject])->Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.album.rawValue)
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "name = %@", albumName)
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            guard let contextArray = (result as? [NSManagedObject]) else {
                return
            }
            completionHandler(contextArray)
        } catch {
            print("Failed")
        }
    }
}
