//
//  AppButtonConfigurations.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit

/// A collection of predefined button configuration helpers used throughout the app.
struct AppButtonConfigurations {

    /// Creates a rounded primary button configuration styled according to the app design system.
    ///
    /// - Parameters:
    ///   - title: The button's title. Default is `"Title"`.
    ///   - cornerStyle: The corner style applied to the button. Default is `.large`.
    ///
    /// - Returns: A `UIButton.Configuration` styled with the app's primary colors and typography.
    static func roundedPrimary(
        title: String = "Title",
        cornerStyle: UIButton.Configuration.CornerStyle = .large
    ) -> UIButton.Configuration {

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Colors.primaryBlue.color
        config.baseForegroundColor = .white
        config.cornerStyle = cornerStyle

        var titleAttr = AttributeContainer()
        titleAttr.font = FontFamily.Manrope.medium.font(size: 18)
        config.attributedTitle = AttributedString(title, attributes: titleAttr)

        return config
    }
}
