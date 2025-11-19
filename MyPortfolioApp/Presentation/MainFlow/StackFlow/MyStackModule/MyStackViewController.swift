//
//  MyStackViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import UIKit

final class MyStackViewController: BaseViewController<MyStackViewModel> {
    // MARK: - Views
    private let contentView = MyStackView()

    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureNavigationTitle()
    }
}

// MARK: - Private extenison
private extension MyStackViewController {
    func configureNavigationTitle() {
        title = Localization.MyStack.navigationTitle
    }

    func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .didTapAtRow(let row):
                    viewModel.didTap(row: row)
                }
            }
            .store(in: &cancellables)

        viewModel.eventPublisher
            .sink { [weak self] event in
                switch event {
                case .didPrepareInitialState(let viewState):
                    self?.contentView.setViewState(viewState)
                case .viewStateDidUpdate(let viewState):
                    self?.contentView.setViewState(viewState)
                }
            }
            .store(in: &cancellables)
    }
}
