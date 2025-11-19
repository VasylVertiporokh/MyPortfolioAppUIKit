//
//  UIStackView+Ext.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

extension UIStackView {
    
    /// Configures the stack view with the given properties.
    ///
    /// - Parameters:
    ///   - axis: The axis along which the arranged views are laid out. Default is `.vertical`.
    ///   - alignment: How the arranged views are aligned perpendicular to the stack's axis. Default is `.fill`.
    ///   - distribution: How the arranged views are sized along the stack's axis. Default is `.fill`.
    ///   - spacing: The spacing between arranged subviews. Default is `0`.
    func setup(axis: NSLayoutConstraint.Axis = .vertical,
               alignment: Alignment = .fill,
               distribution: Distribution = .fill,
               spacing: CGFloat = 0) {
        
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    /// Removes all arranged subviews from the stack view and from its hierarchy.
    func removeAllViews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    /// Adds an empty transparent spacer view to the stack.
    ///
    /// - Parameter size: Optional fixed size for the spacer.
    ///                   Applies height for vertical stacks and width for horizontal stacks.
    func addSpacer(_ size: CGFloat? = nil) {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        addArranged(spacer, size: size)
    }
    
    /// Adds a colored spacer of fixed height to the stack.
    ///
    /// - Parameters:
    ///   - color: The background color of the spacer. Default is `.white`.
    ///   - height: The fixed height of the spacer.
    func addColorSpacer(color: UIColor = .white, height: CGFloat) {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        
        addArrangedSubview(view)
    }
    
    /// Adds a custom separator line of specific dimensions to the stack.
    ///
    /// - Parameters:
    ///   - color: The separator color. Default is `.white`.
    ///   - height: The line height.
    ///   - width: The line width.
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
    
    /// Adds a view to the stack and optionally applies a fixed size depending on the stack axis.
    ///
    /// - Parameters:
    ///   - view: The view to add.
    ///   - size: Optional fixed size.
    ///           For vertical stacks → height constraint is applied.
    ///           For horizontal stacks → width constraint is applied.
    func addArranged(_ view: UIView, size: CGFloat? = nil) {
        addArrangedSubview(view)
        
        guard let size = size else {
            return
        }
        
        switch axis {
        case .vertical:
            view.heightAnchor.constraint(equalToConstant: size).isActive = true
        case .horizontal:
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
        default:
            return
        }
    }
    
    /// Places the given view centered inside another stack with padding (insets) applied.
    ///
    /// The method automatically creates a nested stack view of the opposite axis
    /// to achieve a centered layout.
    ///
    /// - Parameters:
    ///   - view: The view to center.
    ///   - inset: The inset applied on both sides.
    ///   - size: Optional fixed size applied to the nested stack.
    func addCentered(_ view: UIView, inset: CGFloat, size: CGFloat? = nil) {
        let stack = UIStackView()
        
        switch axis {
        case .vertical:
            stack.setup(axis: .horizontal, alignment: .fill, distribution: .fill)
        case .horizontal:
            stack.setup(axis: .vertical, alignment: .fill, distribution: .fill)
        default:
            return
        }
        
        stack.addSpacer(inset)
        stack.addArranged(view)
        stack.addSpacer(inset)
        
        addArranged(stack, size: size)
    }
}
