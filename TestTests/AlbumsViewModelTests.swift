//
//  AlbumsViewModelTests.swift
//  TestTests
//
//  Created by Elene Akhvlediani on 25/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import XCTest
@testable import Test

class AlbumsViewModelTests: XCTestCase {

    let albumsViewModel = AlbumsViewModel(strategy: MockStrategy())
    override func setUp() {
        albumsViewModel.getAlbums {}
    }
    
    func testGetAlbums() {
        XCTAssertEqual(albumsViewModel.albums.count, 1)
        let first = albumsViewModel.albums.first!
        XCTAssertEqual(first.albumName, "test")
        XCTAssertEqual(first.artistName, "Elene")
        XCTAssertEqual(first.imageUrl, "empty")
        XCTAssertEqual(first.isSaved, false)
    }

}

class MockStrategy: GetAlbumStrategy {
    let shouldHaveSearch: Bool = false
    func getAlbums(reloadDataHandler: @escaping ([AlbumCellViewModel]) -> Void) {
        reloadDataHandler([AlbumCellViewModel(albumName: "test", artistName: "Elene", imageUrl: "empty", isSaved: false)])
    }
}
