//
//  HTTPMethods.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

// MARK: - HTTPMethod

/// Represents supported HTTP methods used when making network requests.
enum HTTPMethod: String {

    /// The `OPTIONS` HTTP method.
    case options = "OPTIONS"

    /// The `DELETE` HTTP method.
    case delete = "DELETE"

    /// The `PATCH` HTTP method.
    case patch = "PATCH"

    /// The `POST` HTTP method.
    case post = "POST"

    /// The `GET` HTTP method.
    case get = "GET"

    /// The `PUT` HTTP method.
    case put = "PUT"
}
