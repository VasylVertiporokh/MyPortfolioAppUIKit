//
//  TechnologyStackCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

final class TechnologyStackCoordinator: Coordinator {
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
        let con = UIViewController()
        con.view.backgroundColor = Colors.neutralBackgroundLight.color
        setRoot([con])
    }

    // MARK: - Deinit
    deinit {
        print("Deinit of \(String(describing: self))")
    }
}
