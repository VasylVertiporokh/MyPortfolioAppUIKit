//
//  ProjectDetailsViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import UIKit

final class ProjectDetailsViewController: BaseViewController<ProjectDetailsViewModel> {
    // MARK: - Views
    private let contentView = ProjectDetailsView()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setupBindings()
    }
}

// MARK: - Private extenison
private extension ProjectDetailsViewController {
    func setupBindings() {
        contentView.actionPublisher
            .sink { [unowned self] action in
                switch action {
                case .showInStoreDidTap:
                    viewModel.showInStore()
                case .imageDidSelectAt(let index):
                    viewModel.showSelectedImageAt(index)
                }
            }
            .store(in: &cancellables)
        
        viewModel.eventPublisher
            .sink { [unowned self] event in
                switch event {
                case .didPrepareInitialState(let state):
                    contentView.setViewState(state)
                }
            }
            .store(in: &cancellables)
    }
    
    func setNavigationTitle() {
        title = viewModel.appName
    }
}
