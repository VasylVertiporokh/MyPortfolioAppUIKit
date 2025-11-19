//
//  EndpointBuilderProtocol.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A protocol defining the structure required for building HTTP endpoint requests.
/// Types conforming to this protocol provide path, method, query parameters,
/// headers, body, and optional custom base URL.
protocol EndpointBuilderProtocol {
    
    /// The base URL for the endpoint.
    /// If `nil`, the default base URL from the network provider will be used.
    var baseURL: URL? { get }
    
    /// The relative path appended to the base URL.
    var path: String { get }
    
    /// Optional query parameters added to the URL.
    var query: [String: String]? { get }
    
    /// Additional header fields applied to the request.
    var headerFields: [String: String] { get }
    
    /// The body of the request, which may be raw data, JSON-encoded, or multipart.
    var body: RequestBody? { get }
    
    /// The HTTP method associated with this endpoint.
    var method: HTTPMethod { get }
}

extension EndpointBuilderProtocol {
    
    /// Default empty headers for endpoints that do not define custom headers.
    var headerFields: [String: String] {
        return [:]
    }
}

// MARK: - Internal extension

extension EndpointBuilderProtocol {
    
    /// Default base URL (nil) — uses provider’s injected base URL.
    var baseURL: URL? { nil }
    
    /// Default empty query parameters.
    var query: [String: String]? { nil }
    
    /// Default request body (no body).
    var body: RequestBody? { nil }
    
    /// Creates a fully configured `URLRequest` instance based on the endpoint definition.
    ///
    /// - Parameters:
    ///   - baseUrl: The fallback base URL provided by the network provider.
    ///   - encoder: JSON encoder used for encoding encodable bodies.
    ///   - plugins: An array of request plugins used to modify requests.
    /// - Throws: `RequestBuilderError` if URL or body encoding fails.
    /// - Returns: A fully prepared `URLRequest`.
    func createRequest(
        _ baseUrl: URL,
        _ encoder: JSONEncoder,
        _ plugins: [NetworkPlugin]
    ) throws -> URLRequest {
        
        var request: URLRequest
        
        do {
            request = .init(url: try buildUrl(self.baseURL ?? baseUrl))
        } catch {
            throw error
        }
        
        request.httpMethod = method.rawValue
        
        // Apply headers
        headerFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Apply plugins
        plugins.forEach { $0.modifyRequest(&request) }
        
        // Apply body
        guard let body = body else {
            NetworkLogger.log(request)
            return request
        }
        
        switch body {
        case .rawData(let data):
            request.httpBody = data
            
        case .encodable(let encodable):
            guard let data = try? encoder.encode(encodable) else {
                throw RequestBuilderError.bodyEncodingError
            }
            request.httpBody = data
            
        case .multipartBody(let items):
            let multipartBody = buildMultipartBody(items: items)
            request.httpBody = multipartBody.multipartData
            
            request.setValue(
                "multipart/form-data; boundary=\(multipartBody.boundary)",
                forHTTPHeaderField: "Content-Type"
            )
            request.setValue(
                "\(multipartBody.length)",
                forHTTPHeaderField: "Content-Length"
            )
        }
        
        NetworkLogger.log(request)
        return request
    }
}

// MARK: - Private extension

private extension EndpointBuilderProtocol {
    
    /// Builds a full URL by appending path and optional query parameters.
    ///
    /// - Parameter baseURL: The base URL for the endpoint.
    /// - Throws: `RequestBuilderError` if URL construction fails.
    /// - Returns: A fully constructed URL.
    func buildUrl(_ baseURL: URL) throws -> URL {
        let url = baseURL.appendingPathComponent(path)
        
        guard let query = query else {
            return url
        }
        
        guard var components = URLComponents(string: url.absoluteString) else {
            throw RequestBuilderError.badURL
        }
        
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            throw RequestBuilderError.badURLComponents
        }
        
        return url
    }
    
    /// Builds a multipart/form-data HTTP body from an array of multipart items.
    ///
    /// - Parameter items: A collection of multipart items.
    /// - Returns: A `MultipartBody` instance containing boundary, encoded data, and length.
    func buildMultipartBody(items: [MultipartItem]) -> MultipartBody {
        let requestBody = NSMutableData()
        let boundary: String = UUID().uuidString
        let lineBreak = "\r\n"
        
        for item in items {
            requestBody.append("\(lineBreak)--\(boundary + lineBreak)")
            requestBody.append("Content-Disposition: form-data; name=\"\(item.attachmentKey)\"")
            requestBody.append("; filename=\"\(item.fileName)\"\(lineBreak)")
            requestBody.append("Content-Type: \(item.mimeType.rawValue) \(lineBreak + lineBreak)")
            requestBody.append(item.data)
        }
        
        requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)")
        
        return .init(
            boundary: boundary,
            multipartData: requestBody as Data,
            length: requestBody.count
        )
    }
}

// MARK: - NSMutableData + Append String

fileprivate extension NSMutableData {
    
    /// Appends a UTF-8 string into mutable data.
    ///
    /// - Parameter string: The string to append.
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
