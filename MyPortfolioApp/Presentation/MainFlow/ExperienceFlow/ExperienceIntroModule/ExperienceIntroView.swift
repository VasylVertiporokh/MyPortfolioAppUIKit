//
//  ExperienceIntroView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Combine
import CombineCocoa

enum ExperienceIntroViewAction {
    case actionButtonDidTap
}

final class ExperienceIntroView: BaseView {
    // MARK: - Subviews
    private let containerStackView = UIStackView()
    private let imageStackView = UIStackView()
    private let imageView = RoundedShadowImageView()
    private let labelsStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = UIButton()

    // MARK: - Publishers
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<ExperienceIntroViewAction, Never>()

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
extension ExperienceIntroView {
    func setViewState(_ viewState: ViewState) {
        titleLabel.text = viewState.titleText
        subtitleLabel.text = viewState.subtitleText
        actionButton.configuration?.attributedTitle?.characters = .init(viewState.buttonTitle)
    }

    struct ViewState {
        let titleText: String
        let subtitleText: String
        let buttonTitle: String
    }
}

// MARK: - Private extenison
private extension ExperienceIntroView {
    func initialSetup() {
        setupLayout()
        setupUI()
        bindActions()
    }

    func bindActions() {
        actionButton.tapPublisher
            .map { ExperienceIntroViewAction.actionButtonDidTap }
            .subscribe(actionSubject)
            .store(in: &cancellables)
    }

    func setupUI() {
        backgroundColor = Colors.neutralBackgroundLight.color

        imageView.configure(with: Assets.appLogo.image)

        titleLabel.text = "Vertyporokh Vasyl"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = Colors.neutralTextDark.color
        titleLabel.font = FontFamily.Manrope.medium.font(size: 32)

        subtitleLabel.text = "As an iOS developer, I created this portfolio app to showcase my skills and highlight the projects I’ve worked on."
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.textColor = Colors.neutralTextPrimary.color
        subtitleLabel.font = FontFamily.Manrope.regular.font(size: 18)

        actionButton.configuration = AppButtonConfigurations.roundedPrimary(title: "View my experience")
    }

    func setupLayout() {
        addSubview(containerStackView, constraints: [
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        containerStackView.setup(axis: .vertical, spacing: 16)
        containerStackView.addArrangedSubview(imageStackView)
        containerStackView.addArrangedSubview(labelsStackView)
        containerStackView.setCustomSpacing(32, after: labelsStackView)
        containerStackView.addArrangedSubview(actionButton)

        imageStackView.setup(axis: .vertical, alignment: .center)
        imageStackView.addArrangedSubview(imageView)

        labelsStackView.setup(axis: .vertical, alignment: .center, spacing: 8)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
    }
}
