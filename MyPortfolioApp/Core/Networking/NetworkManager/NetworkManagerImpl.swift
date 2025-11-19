//
//  NetworkManagerImpl.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation
import Combine

/// A concrete implementation of `NetworkManagerProtocol` responsible for executing
/// URL requests using `URLSession` and converting errors into `NetworkError`.
final class NetworkManagerImpl: NetworkManagerProtocol {

    // MARK: - Private properties

    /// The URL session used to perform network requests.
    private let urlSession: URLSession

    // MARK: - Publishers

    /// A publisher that emits token-related network errors (e.g., 401 Unauthorized).
    /// Can be used to trigger token refresh flows.
    private(set) lazy var tokenManagablePublisher = tokenManagableSubject.eraseToAnyPublisher()

    /// Subject used to emit token-specific errors to subscribers.
    private let tokenManagableSubject = PassthroughSubject<NetworkError, Never>()

    // MARK: - Init

    /// Initializes the network manager with a given URLSession.
    /// - Parameter urlSession: The URLSession instance used for data tasks.
    ///                         Defaults to `URLSession.shared`.
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

// MARK: - Internal extension

extension NetworkManagerImpl {

    /// Executes a URL request and returns a publisher containing raw response data.
    ///
    /// The method:
    /// - Maps system network errors to custom `NetworkError`
    /// - Logs responses
    /// - Interprets HTTP status codes
    ///
    /// - Parameter request: The URL request to execute.
    /// - Returns: A publisher emitting `Data` on success or a `NetworkError` on failure.
    func resumeDataTask(_ request: URLRequest) -> AnyPublisher<Data, NetworkError> {
        return urlSession.dataTaskPublisher(for: request)
            .mapError { [weak self] error -> NetworkError in
                guard let self = self else {
                    return NetworkError.unexpectedError
                }
                return self.convertError(error: error as NSError)
            }
            .flatMap { [weak self] output -> AnyPublisher<Data, NetworkError> in
                guard let self = self else {
                    return Fail(error: .unexpectedError)
                        .eraseToAnyPublisher()
                }
                NetworkLogger.log(output)
                return self.handleError(output)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Private extension

private extension NetworkManagerImpl {

    /// Handles HTTP response codes and maps them into proper `NetworkError` values.
    ///
    /// - Parameter output: The output from a `URLSession.DataTaskPublisher`.
    /// - Returns: A publisher emitting data or a mapped network error.
    func handleError(_ output: URLSession.DataTaskPublisher.Output) -> AnyPublisher<Data, NetworkError> {
        guard let httpResponse = output.response as? HTTPURLResponse else {
            fatalError("Unexpected non-HTTP response")
        }

        switch httpResponse.statusCode {
        case 200...399:
            return Just(output.data)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()

        case 401:
            tokenManagableSubject.send(NetworkError.tokenError)
            return Fail(error: NetworkError.tokenError)
                .eraseToAnyPublisher()

        case 400...499:
            return Fail(error: NetworkError.clientError(output.data))
                .eraseToAnyPublisher()

        case 500...599:
            return Fail(error: NetworkError.serverError)
                .eraseToAnyPublisher()

        default:
            return Fail(error: NetworkError.unexpectedError)
                .eraseToAnyPublisher()
        }
    }

    /// Converts an underlying `NSError` from the URL layer into a custom `NetworkError`.
    ///
    /// - Parameter error: The underlying system error.
    /// - Returns: A mapped `NetworkError`.
    func convertError(error: NSError) -> NetworkError {
        switch error.code {
        case NSURLErrorBadURL:
            return .badURLError
        case NSURLErrorTimedOut:
            return .timedOutError
        case NSURLErrorCannotFindHost,
        NSURLErrorCannotConnectToHost:
            return .hostError
        case NSURLErrorHTTPTooManyRedirects:
            return .tooManyRedirectsError
        case NSURLErrorResourceUnavailable:
            return .resourceUnavailable
        default:
            return .unexpectedError
        }
    }
}
