//
//  SceneDelegate.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import Lightbox
import Kingfisher

/// The scene delegate responsible for managing the app's lifecycle within a specific UIWindowScene.
/// Initializes the main window, dependency container, and root coordinator.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The main window associated with this scene.
    var window: UIWindow?

    /// Stores Combine subscriptions for lifecycle-bound tasks.
    var cancellables = Set<AnyCancellable>()

    /// The main application coordinator responsible for handling navigation flows.
    var appCoordinator: AppCoordinator!

    /// The dependency container used throughout the app.
    var appContainer: AppContainer!

    /// The root navigation controller passed to the app coordinator.
    let navigationController: UINavigationController = UINavigationController()

    /// Called when the scene is first created.
    /// Sets up the window, initializes app dependencies, configures `Lightbox`,
    /// and starts the main coordinator.
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        self.window = UIWindow(windowScene: windowScene)
        self.appContainer = AppContainerImpl()

        self.appCoordinator = AppCoordinator(
            window: window!,
            container: appContainer,
            navigationController: navigationController
        )

        self.configureLightbox()
        self.appCoordinator?.start()
    }

    /// Called when the scene is being released by the system.
    /// Occurs when the scene enters the background or its session is discarded.
    func sceneDidDisconnect(_ scene: UIScene) { }

    /// Called when the scene transitions from inactive to active state.
    /// Use this to restart paused tasks.
    func sceneDidBecomeActive(_ scene: UIScene) { }

    /// Called when the scene transitions from active to inactive state.
    /// May happen due to temporary interruptions (e.g., incoming phone call).
    func sceneWillResignActive(_ scene: UIScene) { }

    /// Called when the scene moves from background to foreground.
    /// Restore UI changes made when entering the background.
    func sceneWillEnterForeground(_ scene: UIScene) { }

    /// Called when the scene transitions from foreground to background.
    /// Save data, release shared resources, and store state for restoration.
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

// MARK: - Private extension

private extension SceneDelegate {

    /// Configures global Lightbox settings used for displaying image galleries.
    /// Sets preload behavior and Kingfisher-based asynchronous image loading.
    func configureLightbox() {
        LightboxConfig.preload = 2

        LightboxConfig.loadImage = { imageView, url, completion in
            DispatchQueue.main.async {
                imageView.kf.setImage(with: url) { result in
                    switch result {
                    case .success(let value):
                        completion?(value.image)
                    case .failure:
                        completion?(nil)
                    }
                }
            }
        }
    }
}
