//
//  DetailedPageViewController.swift
//  Test
//
//  Created by Elene Akhvlediani on 24/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import UIKit

class DetailedPageViewController: UIViewController {
    var albumViewModel: AlbumCellViewModel?
    lazy var detailedPageViewModel: DetailedPageViewModel = {
        let viewModel = DetailedPageViewModel(albumViewModel: albumViewModel)
        return viewModel
    }()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        navigationItem.title = albumViewModel?.albumName
    }
    
    private func getInfo() {
        mainView.isHidden = true
        activityIndicator.startAnimating()
        detailedPageViewModel.getAlbumInfo {  [weak self] albumInfo in
            self?.albumNameLabel.text = albumInfo.name
            self?.artistNameLabel.text = albumInfo.artist
            self?.albumImageView.lazyLoad(url: albumInfo.imageUrl) { img in
                self?.albumImageView.setImageWithFadeAnimation(img)
            }
            self?.tracksTableView.reloadData()
            self?.mainView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        detailedPageViewModel.saveAlbum()
    }
}

extension DetailedPageViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedPageViewModel.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = detailedPageViewModel.tracks[indexPath.row]
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(for: BaseTableViewCell.self,
                                                                    reusableIdentifier: item.identifier,
                                                                    for: indexPath)
        cell.set(viewData: item)
        return cell
    }
}
