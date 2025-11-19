//
//  CustomActivityIndicator.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Kingfisher

final class CustomActivityIndicator: Indicator {
    let view: UIView = UIActivityIndicatorView(style: .large)

    func startAnimatingView() {
        guard let spinner = view as? UIActivityIndicatorView else { return }
        spinner.color = Colors.surfaceLightBlue.color
        spinner.transform = .init(scaleX: 1.5, y: 1.5)
        spinner.startAnimating()
    }

    func stopAnimatingView() {
        guard let spinner = view as? UIActivityIndicatorView else { return }
        spinner.stopAnimating()
    }
}
