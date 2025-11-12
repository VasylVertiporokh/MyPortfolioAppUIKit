//
//  UIView+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit

extension UIView {
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    func rounded() {
        clipsToBounds = true
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
