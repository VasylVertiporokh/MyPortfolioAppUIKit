//
//  NetworkError.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

// MARK: - NetworkErrorEnum

/// Represents all possible errors that can occur during a network request.
/// Covers client/server errors, encoding/decoding issues, URL construction problems,
/// and various low-level networking failures.
enum NetworkError: Error {

    /// A client-side error (HTTP status code 4xx).
    /// May include optional response data for decoding server messages.
    case clientError(Data?)

    /// A server-side error (HTTP status code 5xx).
    case serverError

    /// Indicates failure while decoding the response data.
    case decodingError

    /// A non-specific or unexpected error occurred.
    case unexpectedError

    /// The URL used in the request was malformed or invalid.
    case badURLError

    /// The request timed out before completing.
    case timedOutError

    /// The host could not be reached or resolved.
    case hostError

    /// Too many HTTP redirects occurred.
    case tooManyRedirectsError

    /// The requested resource is unavailable.
    case resourceUnavailable

    /// Authentication token error (e.g., unauthorized or expired token).
    case tokenError

    /// Error that occurred when constructing the request.
    case requestError(RequestBuilderError)
}

// MARK: - LocalizedError

extension NetworkError: LocalizedError {

    /// A human-readable description of the network error.
    var errorDescription: String? {
        switch self {

        case .clientError(let data):
            let defaultMessage = "An error occurred on the client side. Please try again later."

            // Attempt to decode a backend-provided error message
            guard let data = data,
                  let model = try? JSONDecoder().decode(ApiErrorResponseModel.self, from: data) else {
                return defaultMessage
            }
            return model.message

        case .serverError:
            return "An error occurred on the server side. Please try again later."

        case .decodingError:
            return "We were unable to interpret the data received from the server. Please try again later."

        case .unexpectedError:
            return "Something unexpected went wrong. Please try again later."

        case .badURLError:
            return "The request URL is invalid. Please try again later."

        case .timedOutError:
            return "The request timed out. Please check your internet connection."

        case .hostError:
            return "Could not connect to the host. Please try again later."

        case .tooManyRedirectsError:
            return "The request encountered too many redirects. Please try again later."

        case .resourceUnavailable:
            return "The requested resource is unavailable."

        case .tokenError:
            return "Authentication error. Please try again later."

        case .requestError(let error):
            return error.requestErrorDescription
        }
    }
}
