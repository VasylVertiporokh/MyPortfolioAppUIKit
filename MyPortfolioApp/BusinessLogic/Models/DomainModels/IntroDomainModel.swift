//
//  IntroDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A domain model representing introduction/experience information
/// used within the app's presentation layer.
struct IntroDomainModel {

    /// The URL to the user's photo.
    let myPhotoUrl: URL

    /// A short description or introduction text.
    let shortInfo: String

    /// The user's full name.
    let myName: String

    /// The title displayed on the action button.
    let actionButtonTitle: String

    /// The title for the LinkedIn button displayed in the interface.
    let linkedinButtonTitle: String

    /// The URL to the LinkedIn profile.
    let linkedinUrl: URL

    // MARK: - Init from response model

    /// Initializes a domain model using a response model received from the backend.
    /// - Parameter response: The decoded `IntroResponseModel` returned by the API.
    init(from response: IntroResponseModel) {
        self.myPhotoUrl = response.myPhotoUrl
        self.shortInfo = response.shortInfo
        self.myName = response.myName
        self.actionButtonTitle = response.actionButtonTitle
        self.linkedinButtonTitle = response.linkedinButtonTitle
        self.linkedinUrl = response.linkedInURL
    }
}
