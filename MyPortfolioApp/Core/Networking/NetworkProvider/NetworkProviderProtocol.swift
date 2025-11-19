//
//  NetworkProviderProtocol.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// Provides base API information required for constructing network requests,
/// such as the root `baseURL` used by all endpoints.
protocol ApiInfo {

    /// The base URL for all API requests.
    var baseURL: URL { get }
}

// MARK: - CombineNetworkServiceProtocol

/// A protocol defining a generic network provider responsible for performing
/// API requests using a given `EndpointBuilderProtocol` type.
///
/// Implementations handle request creation, plugin execution,
/// JSON encoding/decoding, and Combine-based response publishing.
protocol NetworkProviderProtocol {

    // MARK: - Associatedtype

    /// The type describing the available API endpoints.
    associatedtype Endpoint: EndpointBuilderProtocol

    // MARK: - Properties

    /// Provides base API info such as the base URL.
    var apiInfo: ApiInfo { get }

    /// A set of plugins that can modify requests before they are executed.
    var plugins: [NetworkPlugin] { get }

    /// JSON decoder used for decoding responses.
    var decoder: JSONDecoder { get }

    /// JSON encoder used for encoding request bodies.
    var encoder: JSONEncoder { get }

    // MARK: - Methods

    /// Performs a network request for the given endpoint and decodes the response into a Decodable model.
    ///
    /// - Parameter builder: The endpoint describing the request to perform.
    /// - Returns: A publisher emitting the decoded model on success, or `NetworkError` on failure.
    func performWithResponseModel<T: Decodable>(_ builder: Endpoint) -> AnyPublisher<T, NetworkError>

    /// Performs a network request for the given endpoint where no response body is expected.
    ///
    /// - Parameter builder: The endpoint describing the request to perform.
    /// - Returns: A publisher emitting `Void` on success or a `NetworkError` on failure.
    func performWithProcessingResult(_ builder: Endpoint) -> AnyPublisher<Void, NetworkError>

    /// Performs a network request for the given endpoint and returns raw binary response data.
    ///
    /// - Parameter builder: The endpoint describing the request to perform.
    /// - Returns: A publisher emitting `Data` on success or a `NetworkError` on failure.
    func performWithRawData(_ builder: Endpoint) -> AnyPublisher<Data, NetworkError>
}
