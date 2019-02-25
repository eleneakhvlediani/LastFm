//
//  AlbumsViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var albumsViewModel: AlbumsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = albumsViewModel.title
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        albumsViewModel.getAlbums { [weak self] in
            self?.collectionView.reloadData()
            self?.activityIndicator.stopAnimating()
            self?.collectionView.isHidden = false
        }
        if albumsViewModel.shouldHaveSearch {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-search-50"), style: UIBarButtonItem.Style.plain, target: self, action:  #selector(searchClicked))
        }
    }
    
    @objc func searchClicked() {
        let searchViewController: SearchViewController = UIStoryboard.main.instantiate()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsViewModel.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = albumsViewModel.albums[indexPath.row]
        let cell: BaseCollectionViewCell = collectionView.dequeueReusableCell(for: BaseCollectionViewCell.self,
                                                                    reusableIdentifier: item.identifier,
                                                                    for: indexPath)
        cell.set(viewData: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedPageViewController: DetailedPageViewController = UIStoryboard.main.instantiate()
        detailedPageViewController.albumViewModel =  albumsViewModel.albums[indexPath.row]
        navigationController?.pushViewController(detailedPageViewController, animated: true)
    }
}

extension AlbumsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 3 * 10) / 2.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10,
                            left: 10,
                            bottom: 10,
                            right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
