//
//  ProjectsCoordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import Lightbox

/// Coordinator responsible for managing the Projects flow,
/// starting from the intro screen and navigating through the project list
/// and individual project details.
final class ProjectsCoordinator: Coordinator {
    // MARK: - Internal properties

    /// A list of child coordinators associated with this flow.
    var childCoordinators: [Coordinator] = []

    /// The navigation controller used for presenting views within the projects flow.
    var navigationController: UINavigationController

    // MARK: - Publishers

    /// A publisher that emits when the coordinator finishes its flow.
    private(set) lazy var didFinishPublisher = didFinishSubject.eraseToAnyPublisher()

    /// Backing subject for `didFinishPublisher`.
    private let didFinishSubject = PassthroughSubject<Void, Never>()

    // MARK: - Private properties

    /// Dependency container used to build modules within this flow.
    private let container: AppContainer

    /// Stores subscriptions to lifecycle-bound Combine publishers.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// Initializes the ProjectsCoordinator.
    /// - Parameters:
    ///   - navigationController: The navigation controller for this flow.
    ///   - container: Dependency container for constructing modules.
    init(navigationController: UINavigationController, container: AppContainer) {
        self.navigationController = navigationController
        self.container = container
    }

    /// Starts the projects flow by showing the experience introduction module.
    /// Listens for transition events and continues the navigation accordingly.
    func start() {
        let module = ExperienceIntroModuleBuilder.build(container: container)

        module.transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .showPortfolioProjects:
                    self?.showProjectsList()
                case .showLinkedInProfile(let url):
                    self?.openURL(url)
                }
            }
            .store(in: &cancellables)

        setRoot(module.viewController)
    }

    // MARK: - Deinit

    /// Logs the deallocation of the coordinator for debugging purposes.
    deinit {
        print("Deinit of \(String(describing: self))")
    }
}

// MARK: - Private extension
private extension ProjectsCoordinator {

    /// Navigates to the list of portfolio projects.
    /// Sets up transition handling for project selection.
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

    /// Shows detailed information about a selected project.
    /// Handles transitions such as opening the app in the store or viewing image galleries.
    /// - Parameter details: The domain model describing the selected project.
    func showDetails(details: ProjectDescriptionDomainModel) {
        let module = ProjectDetailsModuleBuilder.build(
            container: container,
            descriptionDomainModel: details
        )

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

    /// Opens the full-screen image viewer starting from a selected image index.
    /// - Parameters:
    ///   - selectedImageIndex: The index of the initially displayed image.
    ///   - images: A list of image URLs to display.
    func showSelectedImage(selectedImageIndex: Int, images: [URL]) {
        let images: [LightboxImage] = images.map { .init(imageURL: $0) }
        let controller = LightboxController(images: images, startIndex: selectedImageIndex)
        controller.dynamicBackground = true
        presentModule(controller, animated: true)
    }
}
