//
//  UIView+Constraints.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

extension UIView {

    /// Adds a subview and activates the provided layout constraints.
    ///
    /// - Parameters:
    ///   - other: The view to be added as a subview.
    ///   - constraints: A list of constraints that will be activated after the view is added.
    func addSubview(_ other: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(other)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    /// Adds a subview pinned to the current view's edges using the specified insets.
    ///
    /// - Parameters:
    ///   - other: The view to add.
    ///   - edgeInsets: Insets applied to all edges.
    ///   - safeArea: If `true`, constraints use the safe area layout guide;
    ///               otherwise, they use the view's edges.
    func addSubview(_ other: UIView, withEdgeInsets edgeInsets: UIEdgeInsets, safeArea: Bool = true) {
        if safeArea {
            addSubview(other, constraints: [
                other.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: edgeInsets.left),
                other.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: edgeInsets.top),
                other.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -edgeInsets.right),
                other.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -edgeInsets.bottom)
            ])
        } else {
            addSubview(other, constraints: [
                other.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
                other.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
                other.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right),
                other.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom)
            ])
        }
    }

    /// Creates constraints that pin the given view to all edges with optional insets.
    ///
    /// - Parameters:
    ///   - view: The view to constrain.
    ///   - edgeInsets: The insets to apply to each edge.
    /// - Returns: An array of configured constraints.
    func constraints(for view: UIView,
                     by edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    ) -> [NSLayoutConstraint] {
        [
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeInsets.bottom)
        ]
    }

    /// Creates constraints that pin the given view to the safe area with optional insets.
    ///
    /// - Parameters:
    ///   - view: The view to constrain.
    ///   - edgeInsets: The insets to apply to each edge.
    /// - Returns: An array of constraints using the safe area layout guide.
    func constraintsToSafeArea(for view: UIView,
                               by edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    ) -> [NSLayoutConstraint] {
        [
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: edgeInsets.top),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeInsets.right),
            view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -edgeInsets.bottom)
        ]
    }

    /// Creates constraints that center the given view inside the current view.
    ///
    /// - Parameters:
    ///   - view: The view to center.
    ///   - offsetX: Horizontal offset from center.
    ///   - offsetY: Vertical offset from center.
    /// - Returns: An array of centering constraints.
    func centerConstrains(for view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> [NSLayoutConstraint] {
        [
            view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offsetY),
            view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offsetX)
        ]
    }

    /// Adds a subview and centers it within the current view.
    ///
    /// - Parameter other: The view to center.
    func addSubviewToCenter(_ other: UIView) {
        addSubview(other, constraints: [
            other.centerYAnchor.constraint(equalTo: centerYAnchor),
            other.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    /// Adds a subview, centers it, and applies fixed width and height constraints.
    ///
    /// - Parameters:
    ///   - other: The view to center.
    ///   - width: Fixed width for the view.
    ///   - height: Fixed height for the view.
    func addSubviewToCenter(_ other: UIView, width: CGFloat, height: CGFloat) {
        addSubview(other, constraints: [
            other.centerYAnchor.constraint(equalTo: centerYAnchor),
            other.centerXAnchor.constraint(equalTo: centerXAnchor),
            other.heightAnchor.constraint(equalToConstant: height),
            other.widthAnchor.constraint(equalToConstant: width)
        ])
    }

    /// Inserts a subview below another view and activates the provided constraints.
    ///
    /// - Parameters:
    ///   - other: The view to insert.
    ///   - belowSubview: The reference view.
    ///   - constraints: Constraints applied to the inserted view.
    func insertSubview(_ other: UIView, belowSubview: UIView, constraints: [NSLayoutConstraint]) {
        insertSubview(other, belowSubview: belowSubview)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    /// Inserts a subview above another view and activates the provided constraints.
    ///
    /// - Parameters:
    ///   - other: The view to insert.
    ///   - aboveSubview: The reference view.
    ///   - constraints: Constraints applied to the inserted view.
    func insertSubview(_ other: UIView, aboveSubview: UIView, constraints: [NSLayoutConstraint]) {
        insertSubview(other, aboveSubview: aboveSubview)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    /// Inserts a subview at the specified index and activates the given constraints.
    ///
    /// - Parameters:
    ///   - other: The view to insert.
    ///   - index: The index in the subviews array.
    ///   - constraints: Constraints applied to the inserted view.
    func insertSubview(_ other: UIView, index: Int, constraints: [NSLayoutConstraint]) {
        insertSubview(other, at: index)
        other.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
