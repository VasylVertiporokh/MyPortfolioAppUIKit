//
//  StackInfoResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation

struct StackInfoResponseModel: Decodable {
    let sections: [Section]

    struct Section: Decodable {
        let id: String
        let kind: InfoSectionKind
        let header: String
        let parent: Item
        let children: [Item]
    }

    struct Item: Decodable {
        let title: String
        let imageUrl: URL?
    }

    enum InfoSectionKind: String, Decodable {
        case main
        case skills
        case frameworks
        case network
        case storage
        case additional
    }
}

extension StackInfoResponseModel {
    func toDomain() -> StackInfoDomainModel {
        return .init(
            stackSections: sections.map { section in
                    .init(
                        id: section.id,
                        kind: .init(kind: section.kind),
                        header: section.header,
                        parent: .init(title: section.parent.title, imageUrl: section.parent.imageUrl),
                        children: section.children.map { .init(title: $0.title, imageUrl: $0.imageUrl) }
                    )
            }
        )
    }
}
