//
//  AppConfiguration.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// Represents configuration requirements for the application,
/// including API host information and credentials.
/// Conforms to `ApiInfo` to provide additional API-related metadata.
protocol AppConfiguration: ApiInfo {

    /// The base API host address.
    var apiHost: String { get }

    /// The application identifier used for API requests.
    var appId: String { get }

    /// The API key used for authorization.
    var apiKey: String { get }
}

/// Concrete implementation of `AppConfiguration` that provides
/// host information and credential values for API requests.
final class AppConfigurationImpl: AppConfiguration {

    /// The base API host address.
    private(set) var apiHost: String

    /// The application identifier used for API requests.
    private(set) var appId: String

    /// The API key used for authorization.
    private(set) var apiKey: String

    /// A lazily computed base URL that combines `apiHost`, `appId`, and `apiKey`.
    /// If `apiHost` is not a valid URL, the app will terminate with a fatal error.
    lazy var baseURL: URL = {
        guard let url = URL(string: apiHost) else {
            fatalError("Invalid url")
        }
        let fullUrl = url
            .appendingPathComponent(appId)
            .appendingPathComponent(apiKey)
        return fullUrl
    }()

    // MARK: - Init

    /// Initializes the configuration with API host and credentials.
    /// - Parameters:
    ///   - apiHost: The base API host address.
    ///   - appId: The application identifier.
    ///   - apiKey: The API authorization key.
    init(apiHost: String, appId: String, apiKey: String) {
        self.apiHost = apiHost
        self.appId = appId
        self.apiKey = apiKey
    }
}
