//
//  CoreDataServiceDelegate.swift
//  Test
//
//  Created by Elene Akhvlediani on 25/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
protocol CoreDataServiceDelegate: class {
    func didUpdate()
}

class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?
    init(value: T?) {
        self.value = value
    }
}

extension WeakRef: CoreDataServiceDelegate where T: CoreDataServiceDelegate {
    func didUpdate() {
        value?.didUpdate()
    }
}
