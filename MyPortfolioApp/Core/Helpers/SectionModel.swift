//
//  SectionModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

/// A generic model representing a section in a list-based UI component,
/// such as a table view or collection view.
///
/// - Parameters:
///   - Section: The type representing the section identifier (must be `Hashable`).
///   - Item: The type representing the items within the section (must be `Hashable`).
struct SectionModel<Section: Hashable, Item: Hashable> {

    /// The identifier or metadata associated with this section.
    var section: Section

    /// The items contained within the section.
    var items: [Item]
}
