//
//  RoundedShadowImageView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Kingfisher

final class RoundedShadowImageView: UIView {
    // MARK: - Subviews
    private let shadowContainerView = UIView()
    private let imageView = UIImageView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = bounds.height / 2
        imageView.clipsToBounds = true
        
        shadowContainerView.layer.cornerRadius = imageView.layer.cornerRadius
        shadowContainerView.layer.masksToBounds = false
        shadowContainerView.layer.shadowColor = UIColor.black.cgColor
        shadowContainerView.layer.shadowOpacity = 0.15
        shadowContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowContainerView.layer.shadowRadius = 12
        shadowContainerView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowContainerView.bounds,
            cornerRadius: shadowContainerView.layer.cornerRadius
        ).cgPath
    }
}

// MARK: - Internal extension
extension RoundedShadowImageView {
    func configure(with url: URL) {
        imageView.kf.setImage(with: url, placeholder: Assets.appLogo.image, options: [.transition(.fade(0.33))])
    }
}

// MARK: - Private extenison
private extension RoundedShadowImageView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
        addSubview(shadowContainerView, withEdgeInsets: .zero)
        shadowContainerView.addSubview(imageView, withEdgeInsets: .zero)
    }
    
    func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .custom(indicator: CustomActivityIndicator())
        shadowContainerView.backgroundColor = .clear
    }
}
