//
//  ProjectResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

struct ProjectResponseModel: Codable {
    let objectId: String
    let myAppRating: Int
    let projectName: String
    let shortDescription: String
    let logoURL: URL
    let fullDescription: ProjectDescriptionResponseModel
}

extension ProjectResponseModel {
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

struct ProjectDescriptionResponseModel: Codable {
    let appName: String
    let fullDescription: FullDescription
    let platforms: ListSection
    let features: ListSection
    let myContribution: ListSection
    let technologies: ListSection
    let screenshots: [String]
    let appStoreURL: URL?

    struct FullDescription: Codable {
        let title: String
        let text: String
    }

    struct ListSection: Codable {
        let title: String
        let items: [String]
    }
}

extension ProjectDescriptionResponseModel {
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
