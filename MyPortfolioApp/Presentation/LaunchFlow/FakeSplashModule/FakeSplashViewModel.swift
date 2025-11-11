//
//  FakeSplashViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Combine
import Foundation

final class FakeSplashViewModel: BaseViewModel {
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<FakeSplashTransition, Never>()

    // MARK: - Life cycle
    override func onViewDidLoad() {
        debugPrint("✅ FakeSplashView did load")
    }
}

// MARK: - Internal extension
extension FakeSplashViewModel {
    func splashAnimationFinished() {
        transitionSubject.send(.showMainFlow)
    }
}
