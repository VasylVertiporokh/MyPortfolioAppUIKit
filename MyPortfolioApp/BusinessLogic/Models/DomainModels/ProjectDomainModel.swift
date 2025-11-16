//
//  ProjectDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import Foundation

struct ProjectDomainModel {
    let objectId: String
    var myAppRating: Int = 0
    var name: String = ""
    var shortDescription: String = ""
    var logoURL: URL? = nil
    var description: ProjectDescriptionDomainModel = .init()
}

struct ProjectDescriptionDomainModel {
    var appName: String = ""
    var fullDescription: FullDescription = .init()
    var platforms: ListSection = .init()
    var features: ListSection = .init()
    var myContribution: ListSection = .init()
    var technologies: ListSection = .init()
    var screenshots: [URL] = []
    var appStoreURL: URL? = nil

    // MARK: - Computed properties
    var infoSections: [ListSection] {
        [platforms, features, myContribution, technologies]
    }

    struct FullDescription {
        var title: String = ""
        var text: String = ""
    }

    struct ListSection {
        var title: String = ""
        var items: [String] = []
    }
}
