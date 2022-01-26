//
//  ListViewControllerVM.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation
import UIKit

class ListViewControllerVM: BaseViewControllerVM {

    private(set) var newsModels: [NewsModel]

    init(data: [NewsModel]) {
        self.newsModels = data
        super.init()
    }

    func getDetailVC(at indexPath: IndexPath) -> UIViewController? {
        guard let newsModel = cellVMForItem(at: indexPath) else {
            return nil
        }
        let detailVM = DetailViewControllerVM(data: newsModel)
        return DetailViewController(with: detailVM)
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
