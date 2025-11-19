//
//  MainTabBarViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Combine

final class MainTabBarViewModel: BaseViewModel {
    // MARK: - Transition publisher
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<MainTabBarTransition, Never>()

    // MARK: - Life cycle
    override func onViewDidLoad() {
        debugPrint("✅ MainTabBar did load")
    }
}
