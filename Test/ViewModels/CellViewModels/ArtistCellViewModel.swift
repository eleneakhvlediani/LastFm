//
//  ArtistCellViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation

struct ArtistCellViewModel: BaseCellViewModel {
    let identifier: String = ArtistTableViewCell.className
    let name: String
    let id: String
    let imageUrl: String
    let listenersInfo: String
}
