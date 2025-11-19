//
//  NetworkLogger.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A utility responsible for logging outgoing requests and incoming responses
/// in a human-readable, formatted way.
///
/// Logging is enabled only in **DEBUG** builds.
struct NetworkLogger {

    /// A newline used for formatting log output.
    private static let newLine = "\n"

    /// A divider used to visually separate log sections.
    private static let divider = "---------------------------"

    /// Logs an outgoing `URLRequest` including method, URL, headers, and body (if present).
    ///
    /// - Parameter request: The request to log.
    static func log(_ request: URLRequest) {
        let method = "--method " + "\(request.httpMethod ?? HTTPMethod.get.rawValue) \(newLine)"
        let url: String = "--url " + "\'\(request.url?.absoluteString ?? "")\' \(newLine)"

        var toPrint = newLine + "REQUEST" + newLine + divider + newLine
        var header = ""
        var data: String = ""

        // Log headers
        if let httpHeaders = request.allHTTPHeaderFields,
           !httpHeaders.keys.isEmpty {
            for (key, value) in httpHeaders {
                header += "--header " + "\'\(key): \(value)\' \(newLine)"
            }
        }

        // Log body if present
        if let bodyData = request.httpBody {
            let bodyBytes = ByteCountFormatter().string(
                fromByteCount: Int64(bodyData.count)
            )

            let bodyString = bodyData.prettyPrintedJSONString ?? bodyBytes
            data = "--data '\(bodyString)'"
        }

        toPrint += method + url + header + data + divider + newLine

#if DEBUG
        print(toPrint)
#endif
    }

    /// Logs an incoming HTTP response with status code, headers, and body (if present).
    ///
    /// - Parameter output: The output received from a `URLSession.DataTaskPublisher`.
    static func log(_ output: URLSession.DataTaskPublisher.Output) {
        let url: String = "--url " + "\'\(output.response.url?.absoluteString ?? "")\' \(newLine)"

        var toPrint = newLine + "RESPONSE" + newLine + divider + newLine
        var header: String = ""
        var statusCode: String = ""
        var data: String = "--data "

        // Status code + headers
        if let response = output.response as? HTTPURLResponse {
            statusCode = "--status code " + "\(response.statusCode)" + newLine
            let httpHeaders = response.allHeaderFields

            if !httpHeaders.keys.isEmpty {
                for (key, value) in httpHeaders {
                    header += "--header " + "\'\(key): \(value)\' \(newLine)"
                }
            }
        }

        // Body
        let bodyBytes = ByteCountFormatter().string(
            fromByteCount: Int64(output.data.count)
        )
        data += output.data.prettyPrintedJSONString ?? bodyBytes

        toPrint += url + statusCode + header + data + newLine + divider + newLine

#if DEBUG
        print(toPrint)
#endif
    }
}

// MARK: - Data + Pretty Print

private extension Data {

    /// Attempts to format raw JSON `Data` into a human-readable, pretty-printed string.
    ///
    /// Returns `nil` if the data is not valid JSON.
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
              ) else { return nil }

        return prettyPrintedString as String
    }
}
