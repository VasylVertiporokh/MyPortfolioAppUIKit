//
//  ProjectCollectionViewCell.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import UIKit
import Kingfisher
import SkeletonView

final class ProjectCollectionViewCell: UICollectionViewCell {
    // MARK: - Subviews
    private let containerStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        dropShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
}

// MARK: - Internal extension
extension ProjectCollectionViewCell {
    func setViewState(_ viewState: ViewState) {
        imageView.kf.setImage(with: viewState.projectIconURL, placeholder: Assets.appLogo.image)
        titleLabel.text = viewState.projectTitle
        subtitleLabel.text = viewState.projectDescription
    }

    struct ViewState: Hashable {
        let id: String
        let projectIconURL: URL?
        let projectTitle: String
        let projectDescription: String
    }
}

// MARK: - Private extension
private extension ProjectCollectionViewCell {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        contentView.addSubview(containerStackView, withEdgeInsets: .init(top: 8, left: 8, bottom: 8, right: 8))

        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(lessThanOrEqualTo: imageView.widthAnchor)
        ])
    }

    func setupUI() {
        contentView.backgroundColor = .neutralWhite
        isSkeletonable = true
        containerStackView.isSkeletonable = true

        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true

        titleLabel.textColor = Colors.neutralTextDark.color
        titleLabel.font = FontFamily.Manrope.bold.font(size: 20)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.isSkeletonable = true
        titleLabel.skeletonTextNumberOfLines = 1
        titleLabel.skeletonTextLineHeight = .relativeToFont

        subtitleLabel.textColor = Colors.neutralTextDark.color
        subtitleLabel.font = FontFamily.Manrope.regular.font(size: 12)
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 3
        subtitleLabel.isSkeletonable = true
        subtitleLabel.skeletonTextNumberOfLines = 3
        subtitleLabel.skeletonTextLineHeight = .fixed(12)
    }

    func dropShadow() {
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = false

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius
        ).cgPath
    }
}
