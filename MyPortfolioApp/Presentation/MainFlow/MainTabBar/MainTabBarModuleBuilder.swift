//
//  MainTabBarModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

enum MainTabBarTransition: Transition {
    
}

final class MainTabBarModuleBuilder {
    class func build(container: AppContainer, viewControllers: [UIViewController]) -> Module<MainTabBarTransition, UIViewController> {
        let viewModel = MainTabBarViewModel()
        let viewController = MainTabBarViewController(viewModel: viewModel, viewControllers: viewControllers)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
