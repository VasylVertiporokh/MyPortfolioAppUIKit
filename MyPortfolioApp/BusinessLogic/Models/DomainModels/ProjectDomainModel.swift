//
//  ProjectDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

/// A domain model representing a portfolio project shown in the app.
/// Contains both basic preview information and a detailed description model.
struct ProjectDomainModel {

    /// The unique identifier of the project.
    let objectId: String

    /// A personal rating assigned to the project (0–10 or any custom scale).
    var myAppRating: Int = 0

    /// The project’s display name.
    var name: String = ""

    /// A short summary describing the project.
    var shortDescription: String = ""

    /// The URL to the project's logo image.
    var logoURL: URL? = nil

    /// A nested model containing full project details.
    var description: ProjectDescriptionDomainModel = .init()
}

/// A domain model containing detailed information about a portfolio project,
/// including full description, technical stack, features, screenshots, and more.
struct ProjectDescriptionDomainModel {

    /// The name of the application or project.
    var appName: String = ""

    /// A structured full description containing a title and a textual explanation.
    var fullDescription: FullDescription = .init()

    /// A list of supported platforms (e.g., iOS, Android, Web).
    var platforms: ListSection = .init()

    /// A list of key features available in the project.
    var features: ListSection = .init()

    /// A list describing personal contributions to the project.
    var myContribution: ListSection = .init()

    /// A list of technologies and tools used in the project.
    var technologies: ListSection = .init()

    /// A collection of project screenshots.
    var screenshots: [URL] = []

    /// A URL leading to the App Store or another distribution platform.
    var appStoreURL: URL? = nil

    // MARK: - Computed properties

    /// A combined list of all informational sections (excluding screenshots and full description).
    var infoSections: [ListSection] {
        [platforms, features, myContribution, technologies]
    }

    /// Represents the main full-description block of the project.
    struct FullDescription {

        /// A title describing the section.
        var title: String = ""

        /// A detailed text describing the project in depth.
        var text: String = ""
    }

    /// Represents a reusable list section with a title and a collection of string items.
    struct ListSection {

        /// The title of the section (e.g., "Features", "Technologies").
        var title: String = ""

        /// The items belonging to this section.
        var items: [String] = []
    }
}
