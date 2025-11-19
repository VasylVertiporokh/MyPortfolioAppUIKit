//
//  ProjectsViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit

final class ProjectsViewController: BaseViewController<ProjectsViewModel> {
    // MARK: - Views
    private let contentView = ProjectsView()

    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        navigationController?.navigationBar.tintColor = Colors.primaryBlueDark.color
        title = Localization.Projects.ProjectsList.navigationTitle
    }
}

// MARK: - Private extenison
private extension ProjectsViewController {
    private func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in viewModel.handleAction(action) }
            .store(in: &cancellables)

        viewModel.eventPublisher
        // Delay is added ONLY to visually demonstrate the skeleton loading state
            .debounce(for: 2, scheduler: RunLoop.main)
            .sink { [unowned self] event in
                switch event {
                case .didPrepareInitialState(let viewState):
                    contentView.setViewState(viewState)
                }
            }
            .store(in: &cancellables)
    }
}
