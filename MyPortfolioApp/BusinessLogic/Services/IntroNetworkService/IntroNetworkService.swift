//
//  IntroNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

protocol IntroNetworkService {
    func getIntroInfo() -> AnyPublisher<IntroResponseModel, NetworkError>
}
