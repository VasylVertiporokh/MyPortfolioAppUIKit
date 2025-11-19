//
//  StackInfoEndpointBuilder.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation

enum StackInfoEndpointBuilder {
    case getStack
}

extension StackInfoEndpointBuilder: EndpointBuilderProtocol {
    var path: String {
        switch self {
        case .getStack:
            "data/myInfo/first"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getStack:
                .get
        }
    }

    var body: RequestBody? {
        return nil
    }
}
