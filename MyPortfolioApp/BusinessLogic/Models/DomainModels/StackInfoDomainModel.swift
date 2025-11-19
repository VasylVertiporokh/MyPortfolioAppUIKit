//
//  StackInfoDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 18/11/2025.
//

import Foundation

/// A domain model representing the full technology stack information
/// displayed in the app. Contains grouped sections of stack items.
struct StackInfoDomainModel {

    /// A collection of stack sections, each grouping related stack items.
    var stackSections: [Section] = []

    /// A section representing a group of technologies, tools, or categories.
    struct Section {

        /// A unique identifier for the section.
        var id: String = ""

        /// The type of the section, used to determine rendering and layout.
        var kind: MyStackSection.Kind = .main

        /// The header title displayed above the section.
        var header: String = ""

        /// The parent item that represents the main category of the section.
        var parent: Item

        /// The list of items that belong to this section.
        var children: [Item]
    }

    /// A single item within a technology stack section.
    struct Item {

        /// The display title of the technology or tool.
        let title: String

        /// An optional URL to an icon representing the item.
        let imageUrl: URL?
    }
}
