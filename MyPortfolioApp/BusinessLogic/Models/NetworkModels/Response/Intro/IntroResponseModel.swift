//
//  IntroResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A response model representing introduction/experience data
/// returned from the backend API. Used for decoding JSON responses.
struct IntroResponseModel: Decodable {

    /// The URL to the user's profile photo.
    let myPhotoUrl: URL

    /// A short introduction or description text.
    let shortInfo: String

    /// The user's full name.
    let myName: String

    /// The title for the action button displayed on the intro screen.
    let actionButtonTitle: String

    /// The title for the inkedin button displayed on the intro screen.
    let linkedinButtonTitle: String

    /// The URL to the linkedin profile.
    let linkedInURL: URL
}
