//
//  SearchViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let searchViewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = searchViewModel.title
        searchBar.delegate = searchViewModel
        tableView.isHidden = true
        searchViewModel.tableUpdated = { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
        searchBar.becomeFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchViewModel.items[indexPath.row]
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(for: BaseTableViewCell.self,
                                                                    reusableIdentifier: item.identifier,
                                                                    for: indexPath)
        cell.set(viewData: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumsViewController: AlbumsViewController = UIStoryboard.main.instantiate()
        albumsViewController.name =  searchViewModel.items[indexPath.row].name
        navigationController?.pushViewController(albumsViewController, animated: true)
    }
    
}
