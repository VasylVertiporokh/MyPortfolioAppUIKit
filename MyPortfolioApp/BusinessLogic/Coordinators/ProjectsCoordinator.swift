//
//  ProjectsCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class ProjectsCoordinator: Coordinator {
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

    func start() {
        let module = ExperienceIntroModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { transition in
                switch transition {

                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }

    // MARK: - Deinit
    deinit {
        print("Deinit of \(String(describing: self))")
    }
}
