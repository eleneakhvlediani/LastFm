//
//  BaseTableViewCell.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

protocol BaseCellViewModel {
    var identifier: String { get }
}

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .none
    }
    
    func set(viewData: BaseCellViewModel) {
        fatalError("This method should be overrided")
    }
}

class BaseCollectionViewCell: UICollectionViewCell {
    func set(viewData: BaseCellViewModel) {
        fatalError("This method should be overrided")
    }
}
