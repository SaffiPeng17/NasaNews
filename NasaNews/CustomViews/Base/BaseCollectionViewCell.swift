//
//  BaseCollectionViewCell.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import Foundation
import UIKit

protocol CellSetupProtocol {
    func setupViewModel(viewModel: Codable)
    func updateViews()
}

class BaseCollectionViewCellVM {
    var cellIdentifier: String = "BaseCollectionViewCellVM"
    init() {}
}

class BaseCollectionViewCell<T: Codable>: UICollectionViewCell, CellSetupProtocol {

    private(set) var viewModel: T! {
        didSet {
            self.updateViews()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(viewModel: T) {
        self.init(frame: .zero)
        setupViewModel(viewModel: viewModel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - CellSetupProtocol
    func setupViewModel(viewModel: Codable) {
        if let vm = viewModel as? T {
            self.viewModel = vm
        }
    }

    func updateViews() {}
}
