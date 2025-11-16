//
//  ProjectsCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import Lightbox

final class ProjectsCoordinator: Coordinator {
    // MARK: - Internal properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Publisers
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties
    private let container: AppContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let module = ExperienceIntroModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .showPortfolioProjects:
                    self?.showProjectsList()
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }

    // MARK: - Deinit
    deinit {
        print("Deinit of \(String(describing: self))")
    }
}

// MARK: - Private extenison
private extension ProjectsCoordinator {
    func showProjectsList() {
        let module = ProjectsModuleBuilder.build(container: container)
        module.transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .showProjectDetails(let details):
                    self?.showDetails(details: details)
                }
            }
            .store(in: &cancellables)
        push(module.viewController)
    }

    func showDetails(details: ProjectDescriptionDomainModel) {
        let module = ProjectDetailsModuleBuilder.build(container: container, descriptionDomainModel: details)
        module.transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .showAppInStoreBy(let url):
                    self?.openURL(url)
                case .showSelectedImage(let selectedIndex, let allImages):
                    self?.showSelectedImage(selectedImageIndex: selectedIndex, images: allImages)
                }
            }
            .store(in: &cancellables)
        module.viewController.hidesBottomBarWhenPushed = true
        push(module.viewController)
    }

    func showSelectedImage(selectedImageIndex: Int, images: [URL]) {
        let images: [LightboxImage] = images.map { .init(imageURL: $0) }
        let controller = LightboxController(images: images, startIndex: selectedImageIndex)
        controller.dynamicBackground = true
        presentModule(controller, animated: true)
    }
}
