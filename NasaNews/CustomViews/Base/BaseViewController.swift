//
//  BaseViewController.swift
//  NasaNews
//
//  Created by Saffi on 2022/1/24.
//

import UIKit

protocol ViewControllerSetupProtocol {
    func setupNavigationBar()
    func setupViews()
}

public class BaseViewControllerVM {
    init() {}
}

public class BaseCoreViewController: UIViewController, ViewControllerSetupProtocol {

    // MARK: - init
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }

    deinit {
        print("\(type(of: self)):", #function)
    }

    // MARK: - ViewControllerSetupProtocol
    func setupNavigationBar() {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
    }

    func setupViews() {}
}

public class BaseViewController<T: BaseViewControllerVM>: BaseCoreViewController {

    private(set) var viewModel: T!

    public required init(with viewModel: T) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}
