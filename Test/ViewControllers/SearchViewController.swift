//
//  SearchViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let searchDataSource = SearchViewModel()
    private var throttler = Throttler(seconds: 0.5)
    private var apiClient = LastFmApiClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = searchDataSource.title
        searchDataSource.openDetailedPage = { [weak self] name in
            let albumsViewController: AlbumsViewController = UIStoryboard.main.instantiate()
            albumsViewController.albumsViewModel = AlbumsViewModel(strategy: DownloadStrategy(name: name))
            self?.navigationController?.pushViewController(albumsViewController, animated: true)
        }
        searchDataSource.configureTableView(tableView: tableView)
        searchBar.delegate = self
        tableView.isHidden = true
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDataSource.searchedText = searchText
        throttler.throttle {
            DispatchQueue.main.async { [weak self] in
                self?.search(text: searchText)
            }
        }
    }
    
    private func search(text: String) {
        guard !text.isEmpty else {
            return
        }
        apiClient.search(for: text) { [weak self] result in
            guard self?.searchDataSource.searchedText == text else { return }
            switch result {
            case .success(let artists):
                self?.searchDataSource.items = artists.results.artistmatches.artist.map { artist in
                    return ArtistCellViewModel(name: artist.name,
                                               id: artist.mbid,
                                               imageUrl: artist.imageUrl,
                                               listenersInfo: "Listened by \(artist.listeners)")
                }
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            case .failure(let error):
                print(error)
            }
        }
    }
}
