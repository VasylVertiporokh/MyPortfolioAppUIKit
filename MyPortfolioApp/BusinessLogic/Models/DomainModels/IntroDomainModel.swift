//
//  IntroDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

struct IntroDomainModel {
    let myPhotoUrl: URL
    let shortInfo: String
    let myName: String
    let actionButtonTitle: String

    // MARK: - Init from response model
    init(from response: IntroResponseModel) {
        self.myPhotoUrl = response.myPhotoUrl
        self.shortInfo = response.shortInfo
        self.myName = response.myName
        self.actionButtonTitle = response.actionButtonTitle
    }
}
