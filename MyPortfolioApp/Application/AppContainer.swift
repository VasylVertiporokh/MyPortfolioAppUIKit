//
//  AppContainer.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

protocol AppContainer: AnyObject {
    var appConfiguration: AppConfiguration { get }
    var networkManager: NetworkManagerProtocol { get }
    var introNetworkService: IntroNetworkService { get }
    var projectsNetworkService: ProjectsNetworkService { get }
}

final class AppContainerImpl: AppContainer {
    let appConfiguration: AppConfiguration
    let networkManager: NetworkManagerProtocol
    let introNetworkService: IntroNetworkService
    let projectsNetworkService: ProjectsNetworkService

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
            apiInfo: appConfiguration, networkManager: networkManager
        )
        self.projectsNetworkService = ProjectsNetworkServiceImpl(projectsNetworkProvider)
    }
}
