//
//  MainTabBarViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class MainTabBarViewController: UITabBarController {
    // MARK: - Private properties
    private var viewModel: MainTabBarViewModel
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(viewModel: MainTabBarViewModel, viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Deinit
    deinit {
        print("Deinit of \(String(describing: self))")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.onViewDidLoad()
        setupBindings()
        viewControllers?.enumerated().reversed().forEach({ [unowned self] (ind, _) in
            selectedIndex = ind
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Setup MainTabBarViewController
private extension MainTabBarViewController {
    func setupUI() {
//        tabBar.isTranslucent = true
        tabBar.tintColor = Colors.primaryBlueDark.color
        tabBar.backgroundColor = Colors.tabBarBackground.color
        addShape()
    }

    func setupBindings() { }

    func addShape() {
        tabBar.layer.shadowColor = UIColor.black.cgColor//Colors.primaryBlueDark.color.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 10)
        tabBar.layer.shadowOpacity = 0.8
        tabBar.layer.shadowRadius = 10
        tabBar.layer.cornerRadius = 48
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = false
    }
}
