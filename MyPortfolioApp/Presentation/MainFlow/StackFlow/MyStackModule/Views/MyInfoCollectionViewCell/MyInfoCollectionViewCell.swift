//
//  MyInfoCollectionViewCell.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import UIKit
import Kingfisher

final class MyInfoCollectionViewCell: UICollectionViewListCell {
    // MARK: - Subviews
    private let containerStackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

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
        imageView.image = nil
        titleLabel.text = nil
        imageView.kf.cancelDownloadTask()
    }
}

// MARK: - Internal extension
extension MyInfoCollectionViewCell {
    func setViewState(_ viewState: ViewState) {
        titleLabel.text = viewState.title
        imageView.isHidden = viewState.isChild
        titleLabel.font = viewState.titleFont
        accessories = viewState.cellAccessory

        guard !viewState.isChild else { return }

        imageView.kf.setImage(
            with: viewState.image,
            placeholder: viewState.placeholder
        )
    }

    struct ViewState: Hashable {
        let id = UUID()
        var image: URL?
        var title: String
        var isChild: Bool = false
        var showsDisclosure: Bool = false

        var cellAccessory: [UICellAccessory] {
            isChild ? [] : [.disclosureIndicator()]
        }

        var titleFont: UIFont {
            FontFamily.Manrope.regular.font(size: isChild ? 16 : 20)
        }

        var placeholder: UIImage? {
            Assets.appLogo.image
        }
    }
}

// MARK: - Private extension
private extension MyInfoCollectionViewCell {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        contentView.addSubview(containerStackView, constraints: [
            containerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])

        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.spacing = 32

        containerStackView.addArrangedSubview(imageView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addSpacer()

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100).withPriority(.defaultHigh),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupUI() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill

        titleLabel.textColor = Colors.neutralTextPrimary.color
        titleLabel.font = FontFamily.Manrope.bold.font(size: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
    }
}
