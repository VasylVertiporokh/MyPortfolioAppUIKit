//
//  MyStackViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation
import Combine

enum MyStackViewModelEvent {
    case didPrepareInitialState(MyStackView.ViewState)
    case viewStateDidUpdate(MyStackView.ViewState)
}

final class MyStackViewModel: BaseViewModel {
    // MARK: - Private properties
    private let stackInfoNetworkService: StackInfoNetworkService
    private var stackInfoDomainModel: StackInfoDomainModel = .init()
    private var viewState: MyStackView.ViewState = .init()

    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<MyStackTransition, Never>()

    // MARK: - Event publisher
    private(set) lazy var eventPublisher = eventSubject.eraseToAnyPublisher()
    private let eventSubject = PassthroughSubject<MyStackViewModelEvent, Never>()

    // MARK: - Init
    init(stackInfoNetworkService: StackInfoNetworkService) {
        self.stackInfoNetworkService = stackInfoNetworkService
        super.init()
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        super.onViewDidLoad()
        fetchInfo()
    }
}

// MARK: - Internal extension
extension MyStackViewModel {
    func didTap(row: MyStackRow) {
        guard let sectionIndex = viewState.sections.firstIndex(where: { $0.items.contains(row) }) else { return }
        var sectionModel = viewState.sections[sectionIndex]

        guard sectionModel.section.isExpandable else { return }
        sectionModel.section.isExpanded.toggle()
        sectionModel.items = buildItems(for: sectionModel.section)

        viewState.sections[sectionIndex] = sectionModel
        eventSubject.send(.viewStateDidUpdate(viewState))
    }
}

// MARK: - Private extenison
private extension MyStackViewModel {
    func fetchInfo() {
        isLoadingSubject.send(true)
        stackInfoNetworkService.fetchStackInfo()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else {
                    return
                }
                self?.isLoadingSubject.send(false)
                self?.errorSubject.send(error)
            } receiveValue: { [weak self] response in
                self?.isLoadingSubject.send(false)
                self?.updateDomainModel(response)
            }
            .store(in: &cancellables)
    }

    func updateDomainModel(_ response: StackInfoResponseModel) {
        stackInfoDomainModel = response.toDomain()
        updateInitialState()
    }
    
    func updateInitialState() {
        stackInfoDomainModel.stackSections.forEach { section in
            var infoSection = MyStackSection(kind: section.kind, headerTitle: section.header)
            var items: [MyStackRow] = []

            infoSection.isExpanded = section.kind == .main
            items = buildItems(for: infoSection)

            viewState.sections.append(.init(section: infoSection, items: items))
        }
        eventSubject.send(.didPrepareInitialState(viewState))
    }

    func buildItems(for section: MyStackSection) -> [MyStackRow] {
        guard let domainSection = stackInfoDomainModel.stackSections.first(where: { $0.kind == section.kind }) else {
            return []
        }

        let parentVS = MyInfoCollectionViewCell.ViewState(
            image: domainSection.parent.imageUrl,
            title: domainSection.parent.title,
            isChild: false,
            showsDisclosure: true
        )

        var result: [MyStackRow] = [.myInfo(parentVS)]

        if section.isExpanded {
            let childrenRows: [MyStackRow] = domainSection.children.map { child in
                    .myInfo(
                        .init(
                            image: nil,
                            title: child.title,
                            isChild: true,
                            showsDisclosure: false
                        )
                    )
            }
            result.append(contentsOf: childrenRows)
        }

        return result
    }
}
