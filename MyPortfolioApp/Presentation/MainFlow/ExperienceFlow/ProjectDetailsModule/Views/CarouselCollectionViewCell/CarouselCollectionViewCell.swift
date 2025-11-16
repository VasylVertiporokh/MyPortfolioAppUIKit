//
//  CarouselCollectionViewCell.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 16/11/2025.
//

import UIKit
import Kingfisher

final class CarouselCollectionViewCell: UICollectionViewCell {
    // MARK: - Subviews
    private let imageView = UIImageView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}

// MARK: - Internal extension
extension CarouselCollectionViewCell {
    func setImageUrl(_ url: URL?) {
        imageView.kf.setImage(with: url, placeholder: Assets.appLogo.image)
    }
}

// MARK: - Private extenison
private extension CarouselCollectionViewCell {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
        contentView.addSubview(imageView, withEdgeInsets: .zero)
    }

    func setupUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
    }
}
