//
//  IntroResponseModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

struct IntroResponseModel: Decodable {
    let myPhotoUrl: URL
    let shortInfo: String
    let myName: String
    let actionButtonTitle: String
}
