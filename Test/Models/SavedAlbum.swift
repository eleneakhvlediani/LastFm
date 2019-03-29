//
//  SavedAlbum.swift
//  Test
//
//  Created by Elene Akhvlediani on 25/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import RealmSwift

class SavedAlbum: Object {
    @objc dynamic var name = ""
    @objc dynamic var artist = ""
    @objc dynamic var imageUrl = ""
    var tracks = RealmSwift.List<TrackRealm>()
}

class TrackRealm: Object {
    @objc dynamic var name = ""
}
