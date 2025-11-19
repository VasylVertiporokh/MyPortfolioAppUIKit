//
//  ProjectsNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation
import Combine

/// Network service implementation responsible for fetching portfolio projects
/// using a generic `NetworkProvider` configured with `ProjectsEndpointBuilder`.
final class ProjectsNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol>
where NetworkProvider.Endpoint == ProjectsEndpointBuilder {

    // MARK: - Private properties

    /// The network provider used to perform project-related API requests.
    private let provider: NetworkProvider

    // MARK: - Init

    /// Initializes the projects network service.
    /// - Parameter provider: A network provider capable of handling `ProjectsEndpointBuilder` endpoints.
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension ProjectsNetworkServiceImpl: ProjectsNetworkService {

    /// Fetches a list of portfolio projects from the backend.
    /// - Returns: A publisher emitting an array of `ProjectResponseModel` on success,
    ///            or a `NetworkError` on failure.
    func getProjects() -> AnyPublisher<[ProjectResponseModel], NetworkError> {
        provider.performWithResponseModel(.getProjects)
    }
}
