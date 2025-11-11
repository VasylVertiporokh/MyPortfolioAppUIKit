//
//  UIStackView+Ext.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

extension UIStackView {
    func setup(axis: NSLayoutConstraint.Axis = .vertical, alignment: Alignment = .fill, distribution: Distribution = .fill, spacing: CGFloat = 0) {
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }

    func removeAllViews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    func addSpacer(_ size: CGFloat? = nil) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        addArranged(spacer, size: size)
    }

    func addColorSpacer(color: UIColor = .white, height: CGFloat) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height)
        ])

        addArrangedSubview(view)
    }

    func addCustomSeparator(color: UIColor = .white, height: CGFloat, width: CGFloat) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height),
            view.widthAnchor.constraint(equalToConstant: width)
        ])
        addArrangedSubview(view)
    }

    func addArranged(_ view: UIView, size: CGFloat? = nil) {
        addArrangedSubview(view)
        guard let size = size else {
            return
        }
        switch axis {
        case .vertical:     view.heightAnchor.constraint(equalToConstant: size).isActive = true
        case .horizontal:   view.widthAnchor.constraint(equalToConstant: size).isActive = true
        default: return
        }
    }

    func addCentered(_ view: UIView, inset: CGFloat, size: CGFloat? = nil) {
        let stack = UIStackView()
        switch axis {
        case .vertical:     stack.setup(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 0)
        case .horizontal:   stack.setup(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        default: return
        }
        stack.addSpacer(inset)
        stack.addArranged(view)
        stack.addSpacer(inset)
        addArranged(stack, size: size)
    }
}

