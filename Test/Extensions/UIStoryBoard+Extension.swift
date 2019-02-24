//
//  UIStoryBoard+Extension.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func instantiate<T: NSObjectProtocol>() -> T  {
        guard let viewController = instantiateViewController(withIdentifier: T.className) as? T else {
            fatalError("Unable to instantiate view controller")
        }
        return viewController
    }
}
