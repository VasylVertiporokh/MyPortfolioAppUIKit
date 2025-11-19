//
//  StackInfoNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation
import Combine

/// A network service responsible for fetching information about the
/// technology stack used in the application.
/// Provides access to API calls related to stack details.
protocol StackInfoNetworkService {

    /// Fetches technology stack information from the backend.
    /// - Returns: A publisher emitting `StackInfoResponseModel` on success,
    ///            or `NetworkError` if the request fails.
    func fetchStackInfo() -> AnyPublisher<StackInfoResponseModel, NetworkError>
}
