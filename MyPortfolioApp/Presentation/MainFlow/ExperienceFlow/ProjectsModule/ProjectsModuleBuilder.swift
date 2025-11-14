//
//  ProjectsModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Combine

enum ProjectsTransition: Transition {
    case showProjectDetails(ProjectDescriptionDomainModel)
}

final class ProjectsModuleBuilder {
    class func build(container: AppContainer) -> Module<ProjectsTransition, UIViewController> {
        let viewModel = ProjectsViewModel(projectsNetworkService: container.projectsNetworkService)
        let viewController = ProjectsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
