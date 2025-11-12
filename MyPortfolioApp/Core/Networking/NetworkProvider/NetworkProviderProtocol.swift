//
//  NetworkProviderProtocol.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

protocol ApiInfo {
    var baseURL: URL { get }
}

// MARK: - CombineNetworkServiceProtocol
protocol NetworkProviderProtocol {
    // MARK: - Associatedtype
    associatedtype Endpoint: EndpointBuilderProtocol

    // MARK: - Properties
    var apiInfo: ApiInfo { get }
    var plugins: [NetworkPlugin] { get }
    var decoder: JSONDecoder { get }
    var encoder: JSONEncoder { get }

    // MARK: - Methods
    func performWithResponseModel<T: Decodable>(_ builder: Endpoint) -> AnyPublisher<T, NetworkError>
    func performWithProcessingResult(_ builder: Endpoint) -> AnyPublisher<Void, NetworkError>
    func performWithRawData(_ builder: Endpoint) -> AnyPublisher<Data, NetworkError>
}
