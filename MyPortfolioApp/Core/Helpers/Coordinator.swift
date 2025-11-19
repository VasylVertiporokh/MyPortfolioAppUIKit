//
//  Coordinator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

/// Base coordinator protocol that defines core navigation responsibilities.
protocol Coordinator: AnyObject {
    /// Child coordinators responsible for managing sub-flows.
    var childCoordinators: [Coordinator] { get set }

    /// Main `UINavigationController` used by the coordinator for navigation.
    var navigationController: UINavigationController { get set }

    /// Publisher that emits when the coordinator has finished its flow.
    var didFinishPublisher: AnyPublisher<Void, Never> { get }

    /// Entry point of the coordinator. Call to start the navigation flow.
    func start()
}

extension Coordinator {

    /// Adds a child coordinator to the list of managed coordinators.
    /// - Parameter coordinator: The coordinator to be added.
    func addChild(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }

    /// Removes a child coordinator from the list of managed coordinators.
    /// - Parameter coordinator: The coordinator to be removed.
    func removeChild(coordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    /// Sets the root view controller of the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to be set as the root.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func setRoot(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.setViewControllers([viewController], animated: animated)
    }

    /// Sets multiple view controllers as the root of the navigation stack.
    /// - Parameters:
    ///   - viewControllers: The array of view controllers to be set as the root stack.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func setRoot(_ viewControllers: [UIViewController], animated: Bool = true) {
        self.navigationController.setViewControllers(viewControllers, animated: animated)
    }

    /// Pushes a view controller onto the navigation stack.
    /// - Parameters:
    ///   - viewController: The view controller to push.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController.pushViewController(viewController, animated: animated)
    }

    /// Pops the top view controller from the navigation stack.
    /// - Parameter animated: A Boolean value indicating whether the transition is animated.
    func pop(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }

    /// Pops view controllers until the first view controller of the given type is revealed.
    /// - Parameters:
    ///   - controllerType: The type of the target view controller to pop to.
    ///   - animated: A Boolean value indicating whether the transition is animated.
    func popTo<T: UIViewController>(controllerType: T.Type, animated: Bool = true) {
        if let targetVC = navigationController.viewControllers.first(where: { $0 is T }) {
            self.navigationController.popToViewController(targetVC, animated: animated)
        }
    }

    /// Presents a view controller modally from the navigation controller.
    /// - Parameters:
    ///   - viewController: The view controller to present.
    ///   - animated: A Boolean value indicating whether the presentation is animated.
    func presentModule(_ viewController: UIViewController, animated: Bool) {
        self.navigationController.present(viewController, animated: animated)
    }

    /// Dismisses the given view controller.
    /// - Parameters:
    ///   - viewController: The view controller to dismiss.
    ///   - animated: A Boolean value indicating whether the dismissal is animated.
    func dismiss(_ viewController: UIViewController, animated: Bool = true) {
        viewController.dismiss(animated: animated)
    }

    /// Attempts to open the given URL using `UIApplication`.
    /// - Parameter url: The URL to open.
    func openURL(_ url: URL?) {
        guard let url, UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)
    }
}
