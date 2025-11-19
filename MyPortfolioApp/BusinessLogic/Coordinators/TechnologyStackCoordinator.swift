//
//  TechnologyStackCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

/// Coordinator responsible for managing the Technology Stack flow,
/// displaying information about the technologies and tools used in the project.
final class TechnologyStackCoordinator: Coordinator {
    // MARK: - Internal properties

    /// A list of child coordinators associated with this flow.
    var childCoordinators: [Coordinator] = []

    /// The navigation controller managing the presentation of views in the stack flow.
    var navigationController: UINavigationController

    // MARK: - Publishers

    /// A publisher that emits when the coordinator finishes its flow.
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()

    /// Subject backing the `didFinishPublisher`.
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties

    /// Dependency container used for constructing modules.
    private let container: AppContainer

    /// Stores lifecycle-bound Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// Initializes the TechnologyStackCoordinator.
    /// - Parameters:
    ///   - navigationController: The navigation controller for this flow.
    ///   - container: The dependency container required to build modules.
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    /// Starts the flow by displaying the primary technology stack module.
    func start() {
        let module = MyStackModuleBuilder.build(container: container)
        setRoot([module.viewController])
    }

    // MARK: - Deinit

    /// Logs the deallocation of the coordinator for debugging purposes.
    deinit {
        print("Deinit of \(String(describing: self))")
    }
}
