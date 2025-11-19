//
//  ProjectDetailsView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import UIKit
import Combine
import CombineCocoa

enum ProjectDetailsViewAction {
    case showInStoreDidTap
    case imageDidSelectAt(Int)
}

final class ProjectDetailsView: BaseView {
    // MARK: - Subviews
    private let scrollView = AxisScrollView(axis: .vertical)
    private let containerStackView = UIStackView()
    private let imageCarouselView = ImageCarouselView()
    private let infoSectionsStackView = UIStackView()
    private let openInAppStoreContainerStackView = UIStackView()
    private let openInAppStoreButton = UIButton()
    
    // MARK: - Action publisher
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<ProjectDetailsViewAction, Never>()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal extension
extension ProjectDetailsView {
    func setViewState(_ viewState: ViewState) {
        generateInfoSections(from: viewState.projectInfoSectionViewStates)
        imageCarouselView.setViewState(viewState.imageCarouselViewState)
        openInAppStoreContainerStackView.isHidden = !viewState.canOpenInAppStore
    }
    
    struct ViewState {
        var projectInfoSectionViewStates: [ProjectInfoSectionView.ViewState] = []
        var imageCarouselViewState: ImageCarouselView.ViewState = .init(sectionModel: [])
        var canOpenInAppStore: Bool = false
    }
}

// MARK: - Private extenison
private extension ProjectDetailsView {
    func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }
    
    func bindActions() {
        openInAppStoreButton.tapPublisher
            .map { ProjectDetailsViewAction.showInStoreDidTap }
            .subscribe(actionSubject)
            .store(in: &cancellables)
        
        imageCarouselView.imageTapPublisher
            .map { ProjectDetailsViewAction.imageDidSelectAt($0.row) }
            .subscribe(actionSubject)
            .store(in: &cancellables)
    }
    
    func setupUI() {
        backgroundColor = Colors.neutralBackgroundLight.color
        openInAppStoreButton.configuration = AppButtonConfigurations.roundedPrimary(title: "Show in AppStore")
    }
    
    func setupLayout() {
        addSubview(scrollView, withEdgeInsets: .zero)
        scrollView.contentView.addSubview(containerStackView, withEdgeInsets: .zero)
        
        containerStackView.axis = .vertical
        containerStackView.spacing = 16
        containerStackView.addArrangedSubview(imageCarouselView)
        containerStackView.addArrangedSubview(infoSectionsStackView)
        containerStackView.addArrangedSubview(openInAppStoreContainerStackView)
        openInAppStoreContainerStackView.addArrangedSubview(openInAppStoreButton)
        
        infoSectionsStackView.axis = .vertical
        infoSectionsStackView.spacing = 24
        infoSectionsStackView.isLayoutMarginsRelativeArrangement = true
        infoSectionsStackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        openInAppStoreContainerStackView.axis = .vertical
        openInAppStoreContainerStackView.isLayoutMarginsRelativeArrangement = true
        openInAppStoreContainerStackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            imageCarouselView.heightAnchor.constraint(equalTo: widthAnchor),
            openInAppStoreButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func generateInfoSections(from viewStates: [ProjectInfoSectionView.ViewState]) {
        infoSectionsStackView.removeAllViews()
        
        viewStates.forEach { state in
            let sectionView = ProjectInfoSectionView()
            sectionView.setViewState(state)
            infoSectionsStackView.addArrangedSubview(sectionView)
        }
    }
}
