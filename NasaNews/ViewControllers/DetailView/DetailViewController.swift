//
//  DetailViewController.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/25.
//

import UIKit

class DetailViewController: BaseViewController<DetailViewControllerVM> {

    let scrollView = UIScrollView()
    let contentView = UIView()

    private lazy var lblDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblCopyWrite: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lblContent: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageSize = CGSize(width: UIScreen.main.bounds.width, height: 250)

    override func setupViews() {
        super.setupViews()

        title = "Detial"
        
        setupScrollView()
        setupContentView()
    }

    override func updateViews() {
        super.updateViews()

        lblDate.text = dateFormat(dateString: viewModel.newsModels.date)
        // use thumbnail during downloading original(hdUrl) image
        newsImage.downloadImage(url: viewModel.newsModels.thumbnailImageURL, resizedTo: imageSize)
        newsImage.downloadImage(url: viewModel.newsModels.originalImageurl, resizedTo: imageSize)
        lblTitle.text = viewModel.newsModels.title
        lblCopyWrite.text = viewModel.newsModels.copyright
        lblContent.text = viewModel.newsModels.description
    }
}

private extension DetailViewController {
    func dateFormat(dateString: String) -> String {
        let oriFormatter = DateFormatter()
        oriFormatter.dateFormat = "YYYY-MM-DD"
        let date = oriFormatter.date(from: dateString) ?? Date()

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "yyyy MMM. dd"
        return newFormatter.string(from: date)
    }
}

private extension DetailViewController {
    func setupScrollView() {
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    func setupContentView() {
        contentView.addSubview(lblDate)
        lblDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0).isActive = true
        lblDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        lblDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true

        contentView.addSubview(newsImage)
        newsImage.topAnchor.constraint(equalTo: lblDate.bottomAnchor, constant: 15.0).isActive = true
        newsImage.leftAnchor.constraint(equalTo: lblDate.leftAnchor).isActive = true
        newsImage.rightAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: 250).isActive = true

        contentView.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 15.0).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: lblDate.leftAnchor).isActive = true
        lblTitle.rightAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true

        contentView.addSubview(lblCopyWrite)
        lblCopyWrite.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 15.0).isActive = true
        lblCopyWrite.leftAnchor.constraint(equalTo: lblDate.leftAnchor).isActive = true
        lblCopyWrite.rightAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true

        contentView.addSubview(lblContent)
        lblContent.topAnchor.constraint(equalTo: lblCopyWrite.bottomAnchor, constant: 15.0).isActive = true
        lblContent.leftAnchor.constraint(equalTo: lblDate.leftAnchor).isActive = true
        lblContent.rightAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true
        lblContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
