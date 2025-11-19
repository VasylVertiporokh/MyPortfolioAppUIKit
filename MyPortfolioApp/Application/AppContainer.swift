//
//  AppContainer.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

/// A dependency container protocol defining the core services and configuration
/// required across the application. Implementations provide access to API configuration,
/// network managers, and various feature-specific network services.
protocol AppContainer: AnyObject {

    /// The application's API configuration containing host and credential information.
    var appConfiguration: AppConfiguration { get }

    /// The low-level network manager responsible for executing API requests.
    var networkManager: NetworkManagerProtocol { get }

    /// Service responsible for fetching introduction/experience data.
    var introNetworkService: IntroNetworkService { get }

    /// Service responsible for fetching projects and portfolio data.
    var projectsNetworkService: ProjectsNetworkService { get }

    /// Service responsible for fetching technology stack information.
    var stackInfoNetworkService: StackInfoNetworkService { get }
}

/// Default implementation of the application's dependency container.
/// Creates and wires up all necessary services and configuration
/// used throughout the application.
final class AppContainerImpl: AppContainer {

    /// The application's API configuration.
    let appConfiguration: AppConfiguration

    /// Network manager used for executing API requests.
    let networkManager: NetworkManagerProtocol

    /// Service handling experience/intro-related API operations.
    let introNetworkService: IntroNetworkService

    /// Service handling project and portfolio API operations.
    let projectsNetworkService: ProjectsNetworkService

    /// Service handling technology stack information API operations.
    let stackInfoNetworkService: StackInfoNetworkService

    /// Initializes all services and dependencies used across the app.
    /// Loads configuration from `Plists`, sets up the network manager,
    /// and builds service providers for each feature-specific network service.
    init() {
        self.networkManager = NetworkManagerImpl()

        let appConfiguration = AppConfigurationImpl(
            apiHost: Plists.baseURL,
            appId: Plists.appId,
            apiKey: Plists.apiKey
        )
        self.appConfiguration = appConfiguration

        let introNetworkProvider = NetworkServiceProvider<IntroEndpointBuilder>(
            apiInfo: appConfiguration,
            networkManager: networkManager
        )
        self.introNetworkService = IntroNetworkServiceImpl(introNetworkProvider)

        let projectsNetworkProvider = NetworkServiceProvider<ProjectsEndpointBuilder>(
            apiInfo: appConfiguration,
            networkManager: networkManager
        )
        self.projectsNetworkService = ProjectsNetworkServiceImpl(projectsNetworkProvider)

        let stackInfoNetworkProvider = NetworkServiceProvider<StackInfoEndpointBuilder>(
            apiInfo: appConfiguration,
            networkManager: networkManager
        )
        self.stackInfoNetworkService = StackInfoNetworkServiceImpl(stackInfoNetworkProvider)
    }
}
