//
//  ProjectsEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

/// Defines all API endpoints related to fetching portfolio projects.
enum ProjectsEndpointBuilder {
    /// Endpoint for retrieving the list of projects.
    case getProjects
}

extension ProjectsEndpointBuilder: EndpointBuilderProtocol {

    /// The URL path for each project-related endpoint.
    var path: String {
        switch self {
        case .getProjects:
            "/data/Projects"
        }
    }

    /// The HTTP method used for the request.
    var method: HTTPMethod {
        switch self {
        case .getProjects:
            .get
        }
    }

    /// The request body associated with the endpoint.
    /// Project endpoints do not require a request body.
    var body: RequestBody? {
        return nil
    }
}
