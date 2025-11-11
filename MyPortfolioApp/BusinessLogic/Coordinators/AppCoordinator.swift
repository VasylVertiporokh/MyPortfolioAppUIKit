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
                    print("Hello")
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }
}
