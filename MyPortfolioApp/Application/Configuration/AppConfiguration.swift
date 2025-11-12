//
//  AppConfiguration.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

protocol AppConfiguration: ApiInfo {
    var apiHost: String { get }
    var appId: String { get }
    var apiKey: String { get }
}

final class AppConfigurationImpl: AppConfiguration {
    private(set) var apiHost: String
    private(set) var appId: String
    private(set) var apiKey: String
    
    lazy var baseURL: URL = {
        guard let url = URL(string: apiHost) else {
            fatalError("Invalid url")
        }
        let fullUrl = url.appendingPathComponent(appId).appendingPathComponent(apiKey)
        return fullUrl
    }()
    
    // MARK: - Init
    init(apiHost: String, appId: String, apiKey: String) {
        self.apiHost = apiHost
        self.appId = appId
        self.apiKey = apiKey
    }
}
