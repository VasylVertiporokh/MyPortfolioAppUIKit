//
//  ProjectsEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

enum ProjectsEndpointBuilder {
    case getProjects
}

extension ProjectsEndpointBuilder: EndpointBuilderProtocol {
    var path: String {
        switch self {
        case .getProjects:
            "/data/Projects"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getProjects:
                .get
        }
    }

    var body: RequestBody? {
        return nil
    }
}
