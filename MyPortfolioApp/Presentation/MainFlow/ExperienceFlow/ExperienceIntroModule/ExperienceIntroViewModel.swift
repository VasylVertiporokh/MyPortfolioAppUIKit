//
//  ExperienceIntroViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Combine

final class ExperienceIntroViewModel: BaseViewModel {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<ExperienceIntroTransition, Never>()
    
//    init() {
//
//        super.init()
//    }
    
}

// MARK: - Internal extension
extension ExperienceIntroViewModel {
    func showExperienceList() {
        print("Show")
    }
}
