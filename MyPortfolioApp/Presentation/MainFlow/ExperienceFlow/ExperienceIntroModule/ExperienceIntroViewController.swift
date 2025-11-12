//
//  ExperienceIntroViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit

final class ExperienceIntroViewController: BaseViewController<ExperienceIntroViewModel> {
    // MARK: - Views
    private let contentView = ExperienceIntroView()

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
private extension ExperienceIntroViewController {
    func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .actionButtonDidTap:
                    viewModel.showExperienceList()
                }
            }
            .store(in: &cancellables)

        viewModel.eventPublisher
            .sink { [unowned self] event in
                switch event {
                case .introDidFetch(let info):
                    contentView.setViewState(.init(from: info))
                }
            }
            .store(in: &cancellables)
    }
}
