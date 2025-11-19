//
//  StackInfoNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation
import Combine

/// Network service implementation responsible for fetching technology stack
/// information from the backend.
/// Uses a generic `NetworkProvider` constrained to `StackInfoEndpointBuilder`.
final class StackInfoNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol>
where NetworkProvider.Endpoint == StackInfoEndpointBuilder {

    // MARK: - Private properties

    /// The network provider used to execute API requests related to stack information.
    private let provider: NetworkProvider

    // MARK: - Init

    /// Creates a new instance of `StackInfoNetworkServiceImpl`.
    /// - Parameter provider: A network provider capable of handling `StackInfoEndpointBuilder` endpoints.
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension StackInfoNetworkServiceImpl: StackInfoNetworkService {

    /// Fetches technology stack information from the server.
    /// - Returns: A publisher emitting `StackInfoResponseModel` on success,
    ///            or `NetworkError` when the request fails.
    func fetchStackInfo() -> AnyPublisher<StackInfoResponseModel, NetworkError> {
        provider.performWithResponseModel(.getStack)
    }
}
