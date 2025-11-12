//
//  ApiErrorResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

struct ApiErrorResponseModel: Decodable {
    let code: Int
    let message: String
}
