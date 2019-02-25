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
    }
    
    func addAlbum(album: AlbumInfo) {
        let albumContext = Album(context: context)
        albumContext.name = album.name
        albumContext.artistName = album.artist
        albumContext.imageUrl = album.imageUrl
        album.tracks.track.forEach { track in
            let savedTrack = SavedTrack(context: context)
            savedTrack.name = track.name
            albumContext.addToTracks(savedTrack)
        }
        save()
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
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func deleteAlbum(with albumName: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.album.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            guard let contextArray = (result as? [NSManagedObject]) else {
                return
            }
            let savedAlbums = contextArray.filter {  context  in
                guard let name = (context as? Album)?.name else {
                        return false
                }
                return name == albumName
            }
            savedAlbums.forEach { obj in
                 context.delete(obj)
            }
        } catch {
            print("Failed")
        }
        
        save()
    }
}
