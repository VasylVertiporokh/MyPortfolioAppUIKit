//
//  ProjectResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

/// A response model representing a portfolio project retrieved from the backend.
/// Includes preview information as well as a nested detailed description model.
struct ProjectResponseModel: Codable {

    /// The unique identifier of the project.
    let objectId: String

    /// A personal rating for the project.
    let myAppRating: Int

    /// The project’s display name.
    let projectName: String

    /// A short summary describing the project.
    let shortDescription: String

    /// The URL of the project's logo image.
    let logoURL: URL

    /// A nested model containing the full detailed description of the project.
    let fullDescription: ProjectDescriptionResponseModel
}

extension ProjectResponseModel {

    /// Converts the API response model into a domain model used inside the app.
    /// - Returns: A `ProjectDomainModel` containing mapped project data.
    func toDomain() -> ProjectDomainModel {
        return .init(
            objectId: objectId,
            myAppRating: myAppRating,
            name: projectName,
            shortDescription: shortDescription,
            logoURL: logoURL,
            description: fullDescription.toDomain()
        )
    }
}

/// A detailed response model describing a project, including full description,
/// technologies, supported platforms, screenshots, and more.
struct ProjectDescriptionResponseModel: Codable {

    /// The name of the application or project.
    let appName: String

    /// A structured full description of the project.
    let fullDescription: FullDescription

    /// A list of supported platforms.
    let platforms: ListSection

    /// A list of features implemented in the project.
    let features: ListSection

    /// A list describing personal contributions to the project.
    let myContribution: ListSection

    /// A list of technologies and tools used in the project.
    let technologies: ListSection

    /// A list of screenshot URLs in string form.
    let screenshots: [String]

    /// An optional URL to the App Store or other distribution platform.
    let appStoreURL: URL?

    /// Represents a full textual description of the project.
    struct FullDescription: Codable {

        /// The title of the description section.
        let title: String

        /// A detailed text describing the project.
        let text: String
    }

    /// Represents a list-based section containing a title and items.
    struct ListSection: Codable {

        /// The title of the list section.
        let title: String

        /// The items belonging to the list section.
        let items: [String]
    }
}

extension ProjectDescriptionResponseModel {

    /// Converts the API response model into a domain model used for rendering in the UI.
    /// - Returns: A `ProjectDescriptionDomainModel` containing mapped project details.
    func toDomain() -> ProjectDescriptionDomainModel {
        return .init(
            appName: appName,
            fullDescription: .init(
                title: fullDescription.title,
                text: fullDescription.text
            ),
            platforms: .init(title: platforms.title, items: platforms.items),
            features: .init(title: features.title, items: features.items),
            myContribution: .init(title: myContribution.title, items: myContribution.items),
            technologies: .init(title: technologies.title, items: technologies.items),
            screenshots: screenshots.compactMap { URL(string: $0) },
            appStoreURL: appStoreURL
        )
    }
}
