//
//  NSObjectProtocol+Extension.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 02/11/19.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: Self.self)
    }
}
