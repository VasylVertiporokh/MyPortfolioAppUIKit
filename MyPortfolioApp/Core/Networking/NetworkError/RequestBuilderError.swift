//
//  RequestBuilderError.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

enum RequestBuilderError: Error {
    case bodyEncodingError
    case badURL
    case badURLComponents
}

extension RequestBuilderError: LocalizedError {
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
