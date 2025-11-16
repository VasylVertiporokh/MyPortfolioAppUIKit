//
//  ProjectInfoSectionView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import UIKit

final class ProjectInfoSectionView: BaseView {
    // MARK: - Subviews
    private let containerStackView = UIStackView()
    private let titleLabel = UILabel()
    private let infoContainerStackView = UIStackView()
    private let infoLabel = UILabel()
    
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
extension ProjectInfoSectionView {
    func setViewState(_ viewState: ViewState) {
        titleLabel.text = viewState.title
        infoLabel.attributedText = createInfoAttributedDescription(viewState.infoText)
    }
    
    struct ViewState {
        let title: String
        let infoText: String
    }
}

// MARK: - Private extenison
private extension ProjectInfoSectionView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
        addSubview(containerStackView, withEdgeInsets: .zero)
        
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        infoContainerStackView.axis = .vertical
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(infoContainerStackView)
        infoContainerStackView.addArrangedSubview(infoLabel)
    }
    
    func setupUI() {
        titleLabel.textColor = .black
        titleLabel.font = FontFamily.Manrope.bold.font(size: 24)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        
        infoLabel.font =  FontFamily.Manrope.regular.font(size: 16)
        infoLabel.textColor = Colors.neutralTextPrimary.color
        infoLabel.textAlignment = .natural
        infoLabel.numberOfLines = .zero
    }
    
    func createInfoAttributedDescription(_ description: String) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 2
        paragraph.paragraphSpacing = 4
        paragraph.firstLineHeadIndent = 16
        paragraph.headIndent = 16
        
        let attributed = NSAttributedString(
            string: description,
            attributes: [
                .font: FontFamily.Manrope.regular.font(size: 16),
                .foregroundColor: Colors.neutralTextPrimary.color,
                .paragraphStyle: paragraph
            ]
        )
        return attributed
    }
}
