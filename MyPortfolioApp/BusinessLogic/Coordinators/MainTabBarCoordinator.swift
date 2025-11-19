//
//  MainTabBarCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

/// Coordinator responsible for managing the main tab bar flow,
/// including creation and orchestration of tab-specific coordinators.
final class MainTabBarCoordinator: Coordinator {

    // MARK: - Internal properties

    /// A list of child coordinators responsible for individual tabs.
    var childCoordinators: [Coordinator] = []

    /// The root navigation controller for this coordinator.
    var navigationController: UINavigationController

    // MARK: - Publishers

    /// A publisher that emits when the coordinator has completed its flow.
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()

    /// Backing subject for `didFinishPublisher`.
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties

    /// Dependency container used to build modules.
    private let container: AppContainer

    /// Stores Combine subscriptions for lifecycle management.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// Initializes the main tab bar coordinator.
    /// - Parameters:
    ///   - navigationController: The navigation controller managing the root navigation.
    ///   - container: Dependency container for module building.
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    // MARK: - Deinit

    /// Logs the deallocation of the coordinator instance.
    deinit {
        print("Deinit of \(String(describing: self))")
    }

    /// Starts the tab bar flow by configuring tab-specific coordinators
    /// and setting up the main tab bar module.
    func start() {
        setupProjectsCoordinator()
        setupStackCoordinator()

        let controllers = childCoordinators.compactMap { $0.navigationController }
        let module = MainTabBarModuleBuilder.build(container: container, viewControllers: controllers)
        setRoot(module.viewController)
    }
}

// MARK: - Private extension
private extension MainTabBarCoordinator {

    /// Sets up the coordinator responsible for the Projects tab.
    /// Creates a dedicated navigation controller, assigns a tab bar item,
    /// initializes the coordinator, and starts its flow.
    func setupProjectsCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(
            title: Localization.TabBar.Item.projects,
            image: Assets.TabBar.projectsIcon.image,
            selectedImage: nil
        )

        let coordinator = ProjectsCoordinator(
            navigationController: navController,
            container: container
        )

        childCoordinators.append(coordinator)
        coordinator.start()
    }

    /// Sets up the coordinator responsible for the Technology Stack tab.
    /// Creates a navigation controller, configures its tab bar item,
    /// initializes the coordinator, and starts its associated flow.
    func setupStackCoordinator() {
        let navController = UINavigationController()
        navController.tabBarItem = .init(
            title: Localization.TabBar.Item.stack,
            image: Assets.TabBar.stackIcon.image,
            selectedImage: nil
        )

        let coordinator = TechnologyStackCoordinator(
            navigationController: navController,
            container: container
        )

        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
