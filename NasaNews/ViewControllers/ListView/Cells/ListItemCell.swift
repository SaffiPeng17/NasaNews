//
//  ListItemCell.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import UIKit

class ListItemCell: BaseCollectionViewCell<NewsModel> {

    private lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var lblNewsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        newsImage.image = nil
        lblNewsTitle.text = ""
    }

    override func setupViewModel(viewModel: Codable) {
        super.setupViewModel(viewModel: viewModel)

        contentView.backgroundColor = .lightGray
        contentView.clipsToBounds = true

        addSubview(self.newsImage)
        addSubview(self.lblNewsTitle)

        setupLayout()
        updateViews()
    }

    override func updateViews() {
        super.updateViews()

        let itemWidth = UIScreen.main.bounds.width/4
        newsImage.downloadImage(url: viewModel.thumbnailImageURL, resizedTo: CGSize(width: itemWidth, height: itemWidth))
        lblNewsTitle.text = viewModel.title
    }
}

private extension ListItemCell {
    func setupLayout() {
        let views = ["imageView": newsImage, "title": lblNewsTitle]

        let descImageH = "H:[imageView]"
        let descImageV = "V:[imageView]"
        let imageHConstraints = NSLayoutConstraint.constraints(withVisualFormat: descImageH, options: [], metrics: nil, views: views)
        let imageVConstraints = NSLayoutConstraint.constraints(withVisualFormat: descImageV, options: [], metrics: nil, views: views)
        addConstraints(imageHConstraints)
        addConstraints(imageVConstraints)

        let descTitleH = "H:|-2-[title]-2-|"
        let descTitleV = "V:|-2-[title]-2-|"
        let titleHConstraints = NSLayoutConstraint.constraints(withVisualFormat: descTitleH, options: [], metrics: nil, views: views)
        let titleVConstraints = NSLayoutConstraint.constraints(withVisualFormat: descTitleV, options: [], metrics: nil, views: views)
        addConstraints(titleHConstraints)
        addConstraints(titleVConstraints)
    }
}
