//
//  NetworkManagerProtocol.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// A protocol defining the responsibilities of a network manager
/// capable of executing URL requests and returning raw response data.
protocol NetworkManagerProtocol {

    /// Executes a URL request and returns the resulting data.
    ///
    /// - Parameter requset: The `URLRequest` to be executed.
    /// - Returns: A publisher emitting raw `Data` on success,
    ///            or a `NetworkError` if the request fails.
    func resumeDataTask(_ requset: URLRequest) -> AnyPublisher<Data, NetworkError>
}
