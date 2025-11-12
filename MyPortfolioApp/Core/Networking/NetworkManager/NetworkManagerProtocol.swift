//
//  NetworkManagerProtocol.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func resumeDataTask(_ requset: URLRequest) -> AnyPublisher<Data, NetworkError>
}
