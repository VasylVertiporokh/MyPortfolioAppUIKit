//
//  AppCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

/// The main application coordinator responsible for setting up the root navigation flow,
/// managing global transitions, and initializing the main module structure.
final class AppCoordinator: Coordinator {

    // MARK: - Internal properties

    /// The main application window.
    var window: UIWindow

    /// The root navigation controller managed by the coordinator.
    var navigationController: UINavigationController

    /// A list of child coordinators managing sub-flows of the app.
    var childCoordinators: [Coordinator] = []

    /// Dependency container used to resolve modules and services.
    let container: AppContainer

    /// A publisher that emits when the coordinator has completed its flow.
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()

    /// The subject that backs `didFinishPublisher`.
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties

    /// Stores Combine subscriptions for lifecycle management.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// Initializes the application coordinator with the required components.
    /// - Parameters:
    ///   - window: The main application window.
    ///   - container: The dependency container for module creation.
    ///   - navigationController: The root navigation controller.
    init(
        window: UIWindow,
        container: AppContainer,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
    }

    /// Starts the coordinator by configuring the window, setting the root controller,
    /// and running the fake splash screen flow.
    func start() {
        window.rootViewController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        window.makeKeyAndVisible()
        fakeSplash()
    }
}

// MARK: - Private extension
private extension AppCoordinator {

    /// Launches a fake splash module and handles its transition events.
    /// When the splash completes, it triggers navigation to the main flow.
    func fakeSplash() {
        let module = FakeSplashModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [unowned self] transition in
                switch transition {
                case .showMainFlow:
                    mainFlow()
                }
            }
            .store(in: &cancellables)

        setRoot(module.viewController)
    }

    /// Starts the main tab bar flow by creating and running the `MainTabBarCoordinator`.
    /// Also listens for its finish event to remove it from the child coordinator list.
    func mainFlow() {
        let mainTabBarCoordinator = MainTabBarCoordinator(
            navigationController: navigationController,
            container: container
        )

        childCoordinators.append(mainTabBarCoordinator)

        mainTabBarCoordinator.didFinishPublisher
            .sink { [unowned self] in
                removeChild(coordinator: mainTabBarCoordinator)
            }
            .store(in: &cancellables)
        mainTabBarCoordinator.start()
    }
}
