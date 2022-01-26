//
//  ListViewController.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import UIKit

class ListViewController: BaseViewController<ListViewControllerVM> {

    private lazy var collectionView: UICollectionView = {
        let itemWidth = UIScreen.main.bounds.width/4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListItemCell.self, forCellWithReuseIdentifier: "ListItemCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func setupViews() {
        super.setupViews()

        title = "List"
        view.backgroundColor = .white

        view.addSubview(collectionView)
        setupLayout()
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListItemCell", for: indexPath)
        if let cell = cell as? ListItemCell, let cellVM = viewModel.cellVMForItem(at: indexPath) {
            cell.setupViewModel(viewModel: cellVM)
        }
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = viewModel.getDetailVC(at: indexPath) else {
            return
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

private extension ListViewController {
    func setupLayout() {
        let topConstraints = NSLayoutConstraint(item: collectionView, attribute: .top,
                                                relatedBy: .equal,
                                                toItem: view, attribute: .top,
                                                multiplier: 1.0, constant: 0.0)
        let leadingConstraints = NSLayoutConstraint(item: collectionView, attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: view, attribute: .leading,
                                                    multiplier: 1.0, constant: 0.0)
        let trailingConstraints = NSLayoutConstraint(item: collectionView, attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: view, attribute: .trailing,
                                                     multiplier: 1.0, constant: 0.0)
        let bottomConstraints = NSLayoutConstraint(item: collectionView, attribute: .bottom,
                                                   relatedBy: .equal,
                                                   toItem: view, attribute: .bottom,
                                                   multiplier: 1.0, constant: 0.0)

        NSLayoutConstraint.activate([topConstraints, leadingConstraints, trailingConstraints, bottomConstraints])
    }
}
