//
//  ProjectsNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation
import Combine

final class ProjectsNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol> where NetworkProvider.Endpoint == ProjectsEndpointBuilder {

    // MARK: - Private properties
    private let provider: NetworkProvider

    // MARK: - Init
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension ProjectsNetworkServiceImpl: ProjectsNetworkService {
    func getProjects() -> AnyPublisher<[ProjectResponseModel], NetworkError> {
        provider.performWithResponseModel(.getProjects)
    }
}
