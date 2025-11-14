//
//  ProjectsViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

enum ProjectsViewModelEvent {
    case didPrepareInitialState(ProjectsView.ViewState)
}

final class ProjectsViewModel: BaseViewModel {
    // MARK: - Private properties
    private let projectsNetworkService: ProjectsNetworkService
    private var projectsDomainModel: [ProjectDomainModel] = []
    private var viewState: ProjectsView.ViewState = .init(sectionModel: [])
    
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<ProjectsTransition, Never>()
    
    // MARK: - Event publisher
    private(set) lazy var eventPublisher = eventSubject.eraseToAnyPublisher()
    private let eventSubject = PassthroughSubject<ProjectsViewModelEvent, Never>()
    
    // MARK: - Init
    init(projectsNetworkService: ProjectsNetworkService) {
        self.projectsNetworkService = projectsNetworkService
        super.init()
    }
    
    // MARK: - Life cycle
    override func onViewDidLoad() {
        super.onViewDidLoad()
        fetchProjects()
    }
}

// MARK: - Internal extenison
extension ProjectsViewModel {
    func handleAction(_ action: ProjectsViewAction) {
        switch action {
        case .didSelectItem(let id):
            openDetails(for: id)
        }
    }
}

// MARK: - Private extenison
private extension ProjectsViewModel {
    func fetchProjects() {
        projectsNetworkService.getProjects()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else {
                    return
                }
                self?.errorSubject.send(error)
            } receiveValue: { [weak self] response in
                self?.updateDomainModel(response)
            }
            .store(in: &cancellables)
    }
    
    func updateDomainModel(_ response: [ProjectResponseModel]) {
        let domainModels = response.map { $0.toDomain() }
        projectsDomainModel = domainModels
        updateInitialState()
    }
    
    func updateInitialState() {
        eventSubject.send(
            .didPrepareInitialState(.init(sectionModel: createProjectsSectionState()))
        )
    }
    
    func createProjectsSectionState() -> [SectionModel<ProjectsSection, ProjectRow>] {
        let items = projectsDomainModel
            .sorted { $0.myAppRating > $1.myAppRating }
            .map {
                ProjectRow.projectRow(
                    .init(
                        id: $0.objectId,
                        projectIconURL: $0.logoURL,
                        projectTitle: $0.name,
                        projectDescription: $0.shortDescription
                    )
                )
            }
        return [.init(section: .projects, items: items)]
    }
    
    func openDetails(for id: String) {
        guard let project = projectsDomainModel.first(where: { $0.objectId == id }) else {
            return
        }
        transitionSubject.send(.showProjectDetails(project.description))
    }
}
