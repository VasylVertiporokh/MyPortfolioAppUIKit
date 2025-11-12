//
//  AppCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class AppCoordinator: Coordinator {
    // MARK: - Internal properties
    var window: UIWindow
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let container: AppContainer

    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(
        window: UIWindow,
        container: AppContainer,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.container = container
        self.navigationController = navigationController
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        fakeSplash()
    }
}

// MARK: - Private extenison
private extension AppCoordinator {
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
