//
//  NSLayoutConstraint+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 18/11/2025.
//

import UIKit

extension NSLayoutConstraint {

    /// Sets the priority of the constraint and returns the same instance,
    /// allowing for convenient method chaining.
    ///
    /// - Parameter priority: The layout priority to apply.
    /// - Returns: The updated constraint with the assigned priority.
    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
