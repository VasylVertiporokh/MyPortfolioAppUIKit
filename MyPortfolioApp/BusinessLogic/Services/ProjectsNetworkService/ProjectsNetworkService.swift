//
//  ProjectsNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation
import Combine

/// A network service responsible for fetching portfolio project data.
/// Provides access to all API calls related to project listings.
protocol ProjectsNetworkService {

    /// Fetches the list of portfolio projects from the backend.
    /// - Returns: A publisher emitting an array of `ProjectResponseModel` on success,
    ///            or a `NetworkError` if the request fails.
    func getProjects() -> AnyPublisher<[ProjectResponseModel], NetworkError>
}
