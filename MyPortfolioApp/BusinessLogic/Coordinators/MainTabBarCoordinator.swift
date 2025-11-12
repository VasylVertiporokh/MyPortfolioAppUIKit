//
//  MainTabBarCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class MainTabBarCoordinator: Coordinator {
    // MARK: - Internal properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Publisers
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties
    private let container: AppContainer
    private var cancellables = Set<AnyCancellable>()

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
        setupProjectsCoordinator()
        setupStackCoordinator()

        let controllers = childCoordinators.compactMap { $0.navigationController }
        let module = MainTabBarModuleBuilder.build(container: container, viewControllers: controllers)
        setRoot(module.viewController)
    }
}

// MARK: - Private extenison
private extension MainTabBarCoordinator {
    func setupProjectsCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(title: Localization.TabBar.Item.projects,
                                         image: Assets.TabBar.projectsIcon.image,
                                         selectedImage: nil)
        let coordinator = ProjectsCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func setupStackCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(title: Localization.TabBar.Item.stack,
                                         image: Assets.TabBar.stackIcon.image,
                                         selectedImage: nil)
        let coordinator = TechnologyStackCoordinator(navigationController: navController, container: container)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
