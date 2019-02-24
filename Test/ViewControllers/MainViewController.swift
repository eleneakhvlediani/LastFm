//
//  MainViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let apiClient = LastFmApiClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    private func initNavigationBar() {
        navigationItem.title = "last.fm"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-search-50"), style: UIBarButtonItem.Style.plain, target: self, action:  #selector(searchClicked))
    }
    
    @objc func searchClicked() {
        let searchViewController: SearchViewController = UIStoryboard.main.instantiate()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}

