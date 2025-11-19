//
//  IntroNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// A network service responsible for fetching introduction/experience information.
/// Provides access to API calls related to the intro screen.
protocol IntroNetworkService {

    /// Fetches introduction data from the backend.
    /// - Returns: A publisher emitting `IntroResponseModel` on success
    ///            or `NetworkError` on failure.
    func getIntroInfo() -> AnyPublisher<IntroResponseModel, NetworkError>
}
