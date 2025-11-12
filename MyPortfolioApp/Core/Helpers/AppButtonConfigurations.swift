//
//  AppButtonConfigurations.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit

struct AppButtonConfigurations {
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
