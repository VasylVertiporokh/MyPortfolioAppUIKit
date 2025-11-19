//
//  StackInfoNetworkServiceImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation
import Combine

final class StackInfoNetworkServiceImpl<NetworkProvider: NetworkProviderProtocol> where NetworkProvider.Endpoint == StackInfoEndpointBuilder {
    
    // MARK: - Private properties
    private let provider: NetworkProvider

    // MARK: - Init
    init(_ provider: NetworkProvider) {
        self.provider = provider
    }
}

extension StackInfoNetworkServiceImpl: StackInfoNetworkService {
    func fetchStackInfo() -> AnyPublisher<StackInfoResponseModel, NetworkError> {
        provider.performWithResponseModel(.getStack)
    }
}
