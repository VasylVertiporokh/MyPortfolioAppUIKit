//
//  RequestBuilderError.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// Errors that may occur while building an HTTP request.
enum RequestBuilderError: Error {

    /// Indicates that the request body failed to encode (e.g., JSON encoding failed).
    case bodyEncodingError

    /// Indicates that the constructed URL is invalid.
    case badURL

    /// Indicates that URL components could not be properly assembled.
    case badURLComponents
}

extension RequestBuilderError: LocalizedError {

    /// A human-readable description of the request-building error.
    var requestErrorDescription: String? {
        switch self {
        case .bodyEncodingError:
            return "Error encoding the body"
        case .badURL:
            return "Bad request URL"
        case .badURLComponents:
            return "Bad URL components"
        }
    }
}
