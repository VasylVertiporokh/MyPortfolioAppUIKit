//
//  ApiErrorResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A response model representing an error returned by the backend API.
/// Used to decode structured error information from failed requests.
struct ApiErrorResponseModel: Decodable {

    /// The numeric error code provided by the API.
    let code: Int

    /// A human-readable message describing the error.
    let message: String
}
