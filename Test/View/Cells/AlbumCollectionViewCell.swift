//
//  AlbumCollectionViewCell.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    private var imageUrl: String?
    override func set(viewData: BaseCellViewModel) {
        guard let info = viewData as? AlbumCellViewModel else {
            fatalError("Unexpected view model provided. Excepted AlbumCellViewModel while provided: \(type(of: viewData))")
        }
        albumNameLabel.text = info.albumName
        artistNameLabel.text = info.artistName
        albumImage.image = #imageLiteral(resourceName: "lastFm")
        imageUrl = info.imageUrl
        albumImage.lazyLoad(url: info.imageUrl) { [weak self] image in
            if self?.imageUrl == info.imageUrl {
                self?.albumImage.setImageWithFadeAnimation(image)
            }
        }
    }
}
