//
//  NetworkServiceProvider.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// A generic network service provider responsible for building requests,
/// applying plugins, executing them via a `NetworkManagerProtocol`,
/// and decoding responses using Combine.
///
/// This class serves as the core network layer used across the app.
final class NetworkServiceProvider<Endpoint: EndpointBuilderProtocol>: NetworkProviderProtocol {

    // MARK: - Internal properties

    /// API information containing the base URL used for all endpoint requests.
    private(set) var apiInfo: ApiInfo

    /// JSON decoder used to decode server responses.
    private(set) var decoder: JSONDecoder

    /// JSON encoder used to encode request bodies.
    private(set) var encoder: JSONEncoder

    /// Plugins that can modify outgoing requests (e.g., adding headers).
    private(set) var plugins: [NetworkPlugin]

    // MARK: - Private properties

    /// The network manager responsible for executing URL requests.
    private let networkManager: NetworkManagerProtocol

    // MARK: - Init

    /// Initializes the network service provider.
    ///
    /// - Parameters:
    ///   - apiInfo: Provides the base API URL.
    ///   - decoder: Used to decode API responses. Defaults to `JSONDecoder()`.
    ///   - encoder: Used to encode request bodies. Defaults to `JSONEncoder()`.
    ///   - networkManager: The executor for performing network requests.
    ///   - plugins: Optional array of `NetworkPlugin` instances for request modification.
    init(
        apiInfo: ApiInfo,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder(),
        networkManager: NetworkManagerProtocol,
        plugins: [NetworkPlugin] = []
    ) {
        self.apiInfo = apiInfo
        self.decoder = decoder
        self.encoder = encoder
        self.networkManager = networkManager
        self.plugins = plugins
    }

    // MARK: - Internal methods

    /// Performs a request for a given endpoint and decodes the expected response type.
    ///
    /// - Parameter builder: The endpoint describing the request.
    /// - Returns: A publisher emitting the decoded model on success, or a `NetworkError` on failure.
    func performWithResponseModel<T: Decodable>(_ builder: Endpoint) -> AnyPublisher<T, NetworkError> {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)

            return networkManager.resumeDataTask(request)
                .decode(type: T.self, decoder: decoder)
                .mapError { error -> NetworkError in
                    // Handle decoding errors explicitly
                    guard let _ = error as? DecodingError else {
                        // If it's already a NetworkError, forward it
                        guard let netError = error as? NetworkError else {
                            return .unexpectedError
                        }
                        return netError
                    }
                    return .decodingError
                }
                .eraseToAnyPublisher()

        } catch {
            // Request-building errors
            return Fail(error: .requestError(error as! RequestBuilderError))
                .eraseToAnyPublisher()
        }
    }

    /// Performs a request where no response body is needed (e.g., DELETE, POST without payload).
    ///
    /// - Parameter builder: The endpoint describing the request.
    /// - Returns: A publisher emitting `Void` on success or `NetworkError` on failure.
    func performWithProcessingResult(_ builder: Endpoint) -> AnyPublisher<Void, NetworkError> {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)

            return networkManager.resumeDataTask(request)
                .map { _ in () }
                .eraseToAnyPublisher()

        } catch {
            return Fail(error: .requestError(error as! RequestBuilderError))
                .eraseToAnyPublisher()
        }
    }

    /// Performs a request and returns raw `Data` from the server,
    /// without attempting to decode it.
    ///
    /// - Parameter builder: The endpoint describing the request.
    /// - Returns: A publisher emitting raw `Data`, or a `NetworkError` on failure.
    func performWithRawData(_ builder: Endpoint) -> AnyPublisher<Data, NetworkError> {
        do {
            let request = try builder.createRequest(apiInfo.baseURL, encoder, plugins)

            return networkManager.resumeDataTask(request)
                .eraseToAnyPublisher()

        } catch {
            return Fail(error: .requestError(error as! RequestBuilderError))
                .eraseToAnyPublisher()
        }
    }
}
