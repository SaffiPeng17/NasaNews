//
//  ListViewControllerVM.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation

class ListViewControllerVM: BaseViewControllerVM {

    private(set) var newsModels: [NewsModel]

    init(data: [NewsModel]) {
        self.newsModels = data
        super.init()
    }
}

// MARK: - CollectionView DataSource
extension ListViewControllerVM {
    func numberOfItems() -> Int {
        return newsModels.count
    }

    func cellVMForItem(at indexPath: IndexPath) -> NewsModel? {
        guard indexPath.item < newsModels.count else {
            return nil
        }
        return newsModels[indexPath.item]
    }
}
