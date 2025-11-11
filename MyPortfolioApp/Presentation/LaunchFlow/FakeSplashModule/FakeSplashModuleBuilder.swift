//
//  FakeSplashModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

enum FakeSplashTransition: Transition {
    case showMainFlow
}

final class FakeSplashModuleBuilder {
    class func build(container: AppContainer) -> Module<FakeSplashTransition, UIViewController> {
        let viewModel = FakeSplashViewModel()
        let viewController = FakeSplashViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
