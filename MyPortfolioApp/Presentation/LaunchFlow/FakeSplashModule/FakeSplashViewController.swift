//
//  FakeSplashViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

final class FakeSplashViewController: BaseViewController<FakeSplashViewModel> {
    // MARK: - Views
    private let contentView = FakeSplashView()

    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Private extenison
private extension FakeSplashViewController {
    func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .spalshAnimationFinished:
                    viewModel.splashAnimationFinished()
                }
            }
            .store(in: &cancellables)
    }
}
