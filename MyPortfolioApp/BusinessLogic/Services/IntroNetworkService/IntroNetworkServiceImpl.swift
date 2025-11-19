//
//  IntroNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// Network service implementation responsible for fetching introduction
/// and experience-related data from the backend.
/// Uses a generic `NetworkProvider` constrained to `IntroEndpointBuilder`.
final class IntroNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol>
where NetworkProvider.Endpoint == IntroEndpointBuilder {

    // MARK: - Private properties

    /// The network provider used to execute API requests.
    private let provider: NetworkProvider

    // MARK: - Init

    /// Creates a new instance of `IntroNetworkServiceImpl`.
    /// - Parameter provider: A network provider capable of handling `IntroEndpointBuilder` endpoints.
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension IntroNetworkServiceImpl: IntroNetworkService {

    /// Fetches intro information from the server.
    /// - Returns: A publisher emitting `IntroResponseModel` on success,
    ///            or `NetworkError` on request failure.
    func getIntroInfo() -> AnyPublisher<IntroResponseModel, NetworkError> {
        provider.performWithResponseModel(.getIntro)
    }
}
