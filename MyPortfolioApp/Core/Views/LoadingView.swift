//
//  LoadingView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

final class LoadingView: UIView {
    static let tagValue: Int = 1234123

    var isLoading: Bool = false {
        didSet { isLoading ? start() : stop() }
    }

    private let indicator = UIActivityIndicatorView(style: .large)

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal extension
extension LoadingView {
    func start() {
        indicator.startAnimating()
    }

    func stop() {
        indicator.stopAnimating()
    }
}

// MARK: - Private extenison
private extension LoadingView {
    func initialSetup() {
        tag = LoadingView.tagValue
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        indicator.color = .white
        addSubviewToCenter(indicator)
    }
}
