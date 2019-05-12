//
//  UITableView+Extension.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for cellType: T.Type, reusableIdentifier: String, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? T else {
            fatalError("dequeueReusableCell of type :\(T.self) failed. Probably cell was not registered")
        }
        return cell
    }
    
    func registerNib<T: UITableViewCell>(for cellType: T.Type) {
        self.register(UINib(nibName:  T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for cellType: T.Type, reusableIdentifier: String, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as? T else {
            fatalError("dequeueReusableCell of type :\(T.self) failed. Probably cell was not registered")
        }
        return cell
    }
}
