//
//  ProjectsNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation
import Combine

protocol ProjectsNetworkService {
    func getProjects() -> AnyPublisher<[ProjectResponseModel], NetworkError>
}
