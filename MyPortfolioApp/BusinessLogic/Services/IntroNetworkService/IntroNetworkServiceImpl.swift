//
//  IntroNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

final class IntroNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol> where NetworkProvider.Endpoint == IntroEndpointBuilder {

    // MARK: - Private properties
    private let provider: NetworkProvider

    // MARK: - Init
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension IntroNetworkServiceImpl: IntroNetworkService {
    func getIntroInfo() -> AnyPublisher<IntroResponseModel, NetworkError> {
        provider.performWithResponseModel(.getIntro)
    }
}
