//
//  GetFromDataBaseStartegyTests.swift
//  TestTests
//
//  Created by Elene Akhvlediani on 25/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import XCTest
@testable import Test

class GetFromDataBaseStartegyTests: XCTestCase {

    let getFromDataBase = GetFromDataBaseStrategy(coreDataService: MockCoreData())
    func testExample() {
        getFromDataBase.getAlbums { albums in
            XCTAssertEqual(albums.count, 1)
            let first = albums.first!
            XCTAssertEqual(first.albumName, "test")
            XCTAssertEqual(first.artistName, "Elene")
            XCTAssertEqual(first.imageUrl, "empty")
        }
    }
}

class MockCoreData: CoreDataService {
    override func getAlbums(completionHandler: @escaping (([SavedAlbum]) -> Void)) {
        completionHandler([SavedAlbum(name: "test", artist: "Elene", imageUrl: "empty", tracks: [])])
    }
}
