//
//  IntroEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

enum IntroEndpointBuilder {
    case getIntro
}

extension IntroEndpointBuilder: EndpointBuilderProtocol {
    var path: String {
        switch self {
        case .getIntro:
            "/data/Intro/first"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getIntro:
                .get
        }
    }

    var body: RequestBody? {
        return nil
    }
}
