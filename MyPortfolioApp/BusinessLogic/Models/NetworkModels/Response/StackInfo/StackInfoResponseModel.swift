//
//  StackInfoResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import Foundation

/// A response model representing the full technology stack information
/// returned from the backend API. Contains multiple nested sections describing
/// categories, technologies, tools, and other stack-related items.
struct StackInfoResponseModel: Decodable {

    /// A list of stack sections returned by the backend.
    let sections: [Section]

    /// A section representing a group of related technologies or categories.
    struct Section: Decodable {

        /// A unique identifier for the section.
        let id: String

        /// The type of the section (e.g., main, skills, frameworks).
        let kind: InfoSectionKind

        /// The title header displayed for this section.
        let header: String

        /// The main (parent) item representing this section.
        let parent: Item

        /// A collection of items representing subsections or details.
        let children: [Item]
    }

    /// A single entry in a stack section, representing a technology or tool.
    struct Item: Decodable {

        /// The display title of the technology.
        let title: String

        /// An optional image URL representing the technology.
        let imageUrl: URL?
    }

    /// Enumeration defining the type/category of a section.
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

    /// Converts the API response model into a domain model for internal use in the UI layer.
    /// - Returns: A `StackInfoDomainModel` containing mapped and structured technology stack data.
    func toDomain() -> StackInfoDomainModel {
        return .init(
            stackSections: sections.map { section in
                    .init(
                        id: section.id,
                        kind: .init(kind: section.kind),
                        header: section.header,
                        parent: .init(
                            title: section.parent.title,
                            imageUrl: section.parent.imageUrl
                        ),
                        children: section.children.map {
                            .init(title: $0.title, imageUrl: $0.imageUrl)
                        }
                    )
            }
        )
    }
}
