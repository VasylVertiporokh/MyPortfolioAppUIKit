//
//  ExperienceIntroViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

enum ExperienceIntroViewModelEvent {
    case introDidFetch(IntroDomainModel)
}

final class ExperienceIntroViewModel: BaseViewModel {
    // MARK: - Private properties
    private let introNetworkingService: IntroNetworkService

    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<ExperienceIntroTransition, Never>()

    // MARK: - Event publisher
    private(set) lazy var eventPublisher = eventSubject.eraseToAnyPublisher()
    private let eventSubject = PassthroughSubject<ExperienceIntroViewModelEvent, Never>()

    // MARK: - Init
    init(introNetworkingService: IntroNetworkService) {
        self.introNetworkingService = introNetworkingService
        super.init()
    }

    // MARK: - Life cycle
    override func onViewDidLoad() {
        super.onViewDidLoad()
        fetchIntroData()
    }
}

// MARK: - Internal extension
extension ExperienceIntroViewModel {
    func showExperienceList() {
        print("Show")
    }
}

// MARK: - Private extenison
private extension ExperienceIntroViewModel {
    func fetchIntroData() {
        isLoadingSubject.send(true)
        introNetworkingService.getIntroInfo()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else {
                    return
                }
                self?.isLoadingSubject.send(false)
                self?.errorSubject.send(error)
            } receiveValue: { [weak self] response in
                self?.isLoadingSubject.send(false)
                self?.dataDidFetch(response)
            }
            .store(in: &cancellables)
    }

    func dataDidFetch(_ response: IntroResponseModel) {
        eventSubject.send(.introDidFetch(.init(from: response)))
    }
}
