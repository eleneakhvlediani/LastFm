//
//  MainViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        navigationItem.title = "last.fm"
    }
}

