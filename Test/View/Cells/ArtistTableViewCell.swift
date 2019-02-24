//
//  ArtistTableViewCell.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class ArtistTableViewCell: BaseTableViewCell {
    @IBOutlet weak var listenersLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    private var imageUrl: String?
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        artistImage.layer.cornerRadius = artistImage.frame.width / 2
    }
    
    override func set(viewData: BaseCellViewModel) {
        guard let info = viewData as? ArtistCellViewModel else {
            fatalError("Unexpected view model provided. Excepted ArtistCellViewModel while provided: \(type(of: viewData))")
        }
        listenersLabel.text = info.listenersInfo
        artistName.text = info.name
        artistImage.image = #imageLiteral(resourceName: "lastFm")
        imageUrl = info.imageUrl
        artistImage.lazyLoad(url: info.imageUrl) { [weak self] image in
            if self?.imageUrl == info.imageUrl {
                self?.artistImage.setImageWithFadeAnimation(image)
            }
        }
    }
}
