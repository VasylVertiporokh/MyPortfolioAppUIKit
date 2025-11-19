//
//  StackInfoEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation

/// Defines all API endpoints related to fetching technology stack information.
enum StackInfoEndpointBuilder {
    /// Endpoint for retrieving stack details.
    case getStack
}

extension StackInfoEndpointBuilder: EndpointBuilderProtocol {

    /// The URL path associated with each stack-related endpoint.
    var path: String {
        switch self {
        case .getStack:
            "data/myInfo/first"
        }
    }

    /// The HTTP method used for the request.
    var method: HTTPMethod {
        switch self {
        case .getStack:
            .get
        }
    }

    /// The request body associated with the endpoint.
    /// Stack info endpoints do not require a body.
    var body: RequestBody? {
        return nil
    }
}
