//
//  ProjectDetailsModuleBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import UIKit
import Combine

enum ProjectDetailsTransition: Transition {
    case showAppInStoreBy(URL?)
    case showSelectedImage(selectedIndex: Int, allocatedImages: [URL])
}

final class ProjectDetailsModuleBuilder {
    class func build(
        container: AppContainer,
        descriptionDomainModel: ProjectDescriptionDomainModel
    ) -> Module<ProjectDetailsTransition, UIViewController> {
        let viewModel = ProjectDetailsViewModel(descriptionDomainModel: descriptionDomainModel)
        let viewController = ProjectDetailsViewController(viewModel: viewModel)
        return Module(viewController: viewController, transitionPublisher: viewModel.transitionPublisher)
    }
}
