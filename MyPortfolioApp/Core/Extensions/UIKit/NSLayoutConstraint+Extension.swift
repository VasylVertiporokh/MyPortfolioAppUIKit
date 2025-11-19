//
//  NSLayoutConstraint+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 18/11/2025.
//

import UIKit

extension NSLayoutConstraint {
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
