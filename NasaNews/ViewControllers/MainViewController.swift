//
//  MainViewController.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import UIKit

class MainViewController: BaseCoreViewController {

    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Astronomy Picture of the Day"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var requestButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitle("request", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(requestClicked), for: .touchUpInside)
        return button
    }()

    private var newsModels: [NewsModel] = []

    override func setupViews() {
        super.setupViews()

        fetchNewsData()

        view.addSubview(lblTitle)
        view.addSubview(requestButton)

        setupLayout()
    }

    @objc func requestClicked() {
        let listViewVM = ListViewControllerVM(data: newsModels)
        let listViewVC = ListViewController(with: listViewVM)
        self.navigationController?.pushViewController(listViewVC, animated: true)
    }
}

private extension MainViewController {
    func fetchNewsData() {
        NetworkManager.getNews(urlString: Network.dataURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.newsModels = data

            case .failure(let error):
                print("fetch news error:", error)
            }
        }
    }

    func setupLayout() {
        let views = ["label": lblTitle, "button": requestButton]

        let descTitleH = "H:[label]"
        let descButtonH = "H:[button(100)]"
        let descVertical = "V:[label(20)]-40-[button(17)]"

        let titleHConstraints = NSLayoutConstraint.constraints(withVisualFormat: descTitleH, options: [], metrics: nil, views: views)
        let buttonHConstraints = NSLayoutConstraint.constraints(withVisualFormat: descButtonH, options: [], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: descVertical, options: [], metrics: nil, views: views)
        view.addConstraints(titleHConstraints)
        view.addConstraints(buttonHConstraints)
        view.addConstraints(verticalConstraints)

        let centerXTitle = NSLayoutConstraint(item: lblTitle, attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: view, attribute: .centerX,
                                              multiplier: 1.0, constant: 0.0)
        let centerXButton = NSLayoutConstraint(item: requestButton, attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: view, attribute: .centerX,
                                               multiplier: 1.0, constant: 0.0)
        let centerYTitle = NSLayoutConstraint(item: lblTitle, attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: view, attribute: .centerY,
                                              multiplier: 1.0, constant: -50.0)
        NSLayoutConstraint.activate([centerXTitle, centerYTitle, centerXButton])
    }
}
