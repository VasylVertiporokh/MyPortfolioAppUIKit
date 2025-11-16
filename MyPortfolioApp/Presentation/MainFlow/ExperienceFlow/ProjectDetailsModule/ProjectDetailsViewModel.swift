//
//  ProjectDetailsViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import Foundation
import Combine

enum ProjectDetailsViewModelEvent {
    case didPrepareInitialState(ProjectDetailsView.ViewState)
}

final class ProjectDetailsViewModel: BaseViewModel {
    // MARK: - Private properties
    private let descriptionDomainModel: ProjectDescriptionDomainModel
    private var viewState: ProjectDetailsView.ViewState = .init()

    // MARK: - Computed properties
    var appName: String {
        descriptionDomainModel.appName
    }

    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<ProjectDetailsTransition, Never>()

    // MARK: - Event publisher
    private(set) lazy var eventPublisher = eventSubject.eraseToAnyPublisher()
    private let eventSubject = CurrentValueSubject<ProjectDetailsViewModelEvent, Never>(.didPrepareInitialState(.init()))

    // MARK: - Init
    init(descriptionDomainModel: ProjectDescriptionDomainModel) {
        self.descriptionDomainModel = descriptionDomainModel
        super.init()
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        super.onViewDidLoad()
        updateInitialState()
    }
}

// MARK: - Internal extension
extension ProjectDetailsViewModel {
    func showInStore() {
        transitionSubject.send(.showAppInStoreBy(descriptionDomainModel.appStoreURL))
    }

    func showSelectedImageAt(_ index: Int) {
        transitionSubject.send(
            .showSelectedImage(
                selectedIndex: index,
                allocatedImages: descriptionDomainModel.screenshots
            )
        )
    }
}

// MARK: - Private extenison
private extension ProjectDetailsViewModel {
    func updateInitialState() {
        viewState = .init(
            projectInfoSectionViewStates: makeProjectInfoSectionViewStates(from: descriptionDomainModel),
            imageCarouselViewState: makeImageCarouselViewState(from: descriptionDomainModel),
            canOpenInAppStore: descriptionDomainModel.appStoreURL != nil
        )
        eventSubject.send(.didPrepareInitialState(viewState))
    }

    func makeProjectInfoSectionViewStates(
        from model: ProjectDescriptionDomainModel
    ) -> [ProjectInfoSectionView.ViewState] {

        var sections: [ProjectInfoSectionView.ViewState] = []

        sections.append(
            .init(
                title: model.fullDescription.title,
                infoText: model.fullDescription.text
            )
        )

        let additionalSections = model.infoSections.map {
            ProjectInfoSectionView.ViewState(
                title: $0.title,
                infoText: makeString(from: $0.items)
            )
        }

        sections.append(contentsOf: additionalSections)

        return sections
    }
    func makeImageCarouselViewState(from domainModel: ProjectDescriptionDomainModel) -> ImageCarouselView.ViewState {
        .init(
            sectionModel: [
                .init(
                    section: .imagesSection,
                    items: domainModel.screenshots.map { url in .image(url) }
                )
            ]
        )
    }

    func makeString(from stringArray: [String]) -> String {
        stringArray.map { "• " + $0 }.joined(separator: "\n")
    }
}
