//
//  AlbumCellViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
struct AlbumCellViewModel: BaseCellViewModel {
    let identifier: String = AlbumCollectionViewCell.className
    let albumName: String
    let artistName: String
    let imageUrl: String
}
