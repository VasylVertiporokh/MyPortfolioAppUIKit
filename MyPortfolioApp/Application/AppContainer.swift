//
//  AppContainer.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

protocol AppContainer: AnyObject {
    var appConfiguration: AppConfiguration { get }
}

final class AppContainerImpl: AppContainer {
    let appConfiguration: AppConfiguration

    init() {
        let appConfiguration = AppConfigurationImpl(
            apiHost: Plists.baseURL,
            appId: Plists.apiId,
            apiKey: Plists.apiId
        )
        self.appConfiguration = appConfiguration
    }
}
