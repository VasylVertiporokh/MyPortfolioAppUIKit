//
//  MainTabBarCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class MainTabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - AppContainer
    private let container: AppContainer

    // MARK: - Init
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    // MARK: - Deinit
    deinit {
        print("Deinit of \(String(describing: self))")
    }

    func start() {
//        handleAuthorizationStatus()
//        setupHomeCoordinator()
//        setupAddAdvertisementCoordinator()
//        setupFavoriteCoordinator()
//        setupSettingsCoordinator()

//        let controllers = childCoordinators.compactMap { $0.navigationController }
//        let module = MainTabBarModuleBuilder.build(container: container, viewControllers: controllers)
//        setRoot(module.viewController)
    }
}
