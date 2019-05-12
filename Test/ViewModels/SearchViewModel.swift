//
//  SearchViewModel.swift
//  Test
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel: NSObject, UITableViewDelegate, UITableViewDataSource {
    let title = "Search"
    var items = [ArtistCellViewModel]()
    var searchedText: String = ""
    var openDetailedPage: ((String)->Void)?
    
    override init() {
        super.init()
    }
    
    func configureTableView(tableView: UITableView) {
        tableView.dataSource = searchDataSource
        tableView.delegate = searchDataSource
        tableView.registerNib(for: ArtistTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell: BaseTableViewCell = tableView.dequeueReusableCell(for: BaseTableViewCell.self, reusableIdentifier: item.identifier,
                                                                    for: indexPath)
        cell.set(viewData: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = items[indexPath.row].name
        openDetailedPage?(name)
    }
}
