//
//  SearchViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController{
    @IBOutlet weak var searchBar: UISearchBar!
    let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = searchViewModel
    }
}
