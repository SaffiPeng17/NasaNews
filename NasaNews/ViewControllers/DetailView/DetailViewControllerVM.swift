//
//  DetailViewControllerVM.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/25.
//

import Foundation

class DetailViewControllerVM: BaseViewControllerVM {

    private(set) var newsModels: NewsModel

    init(data: NewsModel) {
        self.newsModels = data
        super.init()
    }
}
