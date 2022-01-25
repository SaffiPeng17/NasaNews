//
//  ListItemCellVM.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation
import UIKit

class ListItemCellVM: BaseCollectionViewCellVM {

    private(set) var newsModel: NewsModel?

    init(with model: NewsModel) {
        super.init()
        self.newsModel = model
    }
}
