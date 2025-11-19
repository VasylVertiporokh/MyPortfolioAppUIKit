//
//  IntroEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// Defines all API endpoints related to the Intro feature.
enum IntroEndpointBuilder {
    /// Endpoint for fetching introduction/experience data.
    case getIntro
}

extension IntroEndpointBuilder: EndpointBuilderProtocol {

    /// The URL path associated with each Intro endpoint.
    var path: String {
        switch self {
        case .getIntro:
            "/data/Intro/first"
        }
    }

    /// The HTTP method used for the request.
    var method: HTTPMethod {
        switch self {
        case .getIntro:
            .get
        }
    }

    /// The request body for the endpoint, if applicable.
    /// Intro endpoints do not send a body.
    var body: RequestBody? {
        return nil
    }
}
