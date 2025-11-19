//
//  MyStackModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import UIKit
import Combine

enum MyStackTransition: Transition {
    
}

final class MyStackModuleBuilder {
    class func build(container: AppContainer) -> Module<MyStackTransition, UIViewController> {
        let viewModel = MyStackViewModel(stackInfoNetworkService: container.stackInfoNetworkService)
        let viewController = MyStackViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
