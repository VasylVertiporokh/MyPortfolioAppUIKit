//
//  ExperienceIntroModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Combine

enum ExperienceIntroTransition: Transition {
    case showPortfolioProjects
    case showLinkedInProfile(URL?)
}

final class ExperienceIntroModuleBuilder {
    class func build(container: AppContainer) -> Module<ExperienceIntroTransition, UIViewController> {
        let viewModel = ExperienceIntroViewModel(introNetworkingService: container.introNetworkService)
        let viewController = ExperienceIntroViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
