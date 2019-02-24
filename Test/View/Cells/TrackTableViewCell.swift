//
//  TrackTableViewCell.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit
class TrackTableViewCell: BaseTableViewCell {
    @IBOutlet weak var name: UILabel!
    override func set(viewData: BaseCellViewModel) {
        guard let info = viewData as? TrackCellViewModel else {
            fatalError("Unexpected view model provided. Excepted TrackCellViewModel while provided: \(type(of: viewData))")
        }
        name.text = info.name
    }
}
