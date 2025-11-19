//
//  MyStackHeaderView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 19/11/2025.
//

import UIKit

final class MyStackHeaderView: UICollectionViewListCell {
    func configure(title: String) {
        var content = defaultContentConfiguration()
        content.text = title
        content.textProperties.font = FontFamily.Manrope.light.font(size: 18)
        self.contentConfiguration = content
    }
}
