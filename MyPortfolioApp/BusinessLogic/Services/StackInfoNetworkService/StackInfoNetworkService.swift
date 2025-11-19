//
//  StackInfoNetworkService.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation
import Combine

protocol StackInfoNetworkService {
    func fetchStackInfo() -> AnyPublisher<StackInfoResponseModel, NetworkError>
}
