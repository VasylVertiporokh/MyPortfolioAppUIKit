//
//  MyStackView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 17/11/2025.
//

import UIKit
import Combine
import CombineCocoa

enum MyStackViewAction {
    case didTapAtRow(MyStackRow)
}

final class MyStackView: BaseView {
    // MARK: - Subviews
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<MyStackSection, MyStackRow>?

    // MARK: - Action publisher
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<MyStackViewAction, Never>()

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
extension MyStackView {
    func setViewState(_ viewState: ViewState) {
        setupSnapshot(sections: viewState.sections)
    }

    struct ViewState {
        var sections: [SectionModel<MyStackSection, MyStackRow>] = []
    }
}

// MARK: - Private extension
private extension MyStackView {
    func initialSetup() {
        setupLayout()
        setupDataSource()
        setupUI()
        bindActions()
    }

    func bindActions() {
        collectionView.didSelectItemPublisher
            .sink { [unowned self] indexPath in
                guard let row = dataSource?.itemIdentifier(for: indexPath) else {
                    return
                }
                switch row {
                case .myInfo(let viewState):
                    if !viewState.isChild {
                        collectionView.deselectItem(at: indexPath, animated: true)
                        actionSubject.send(.didTapAtRow(row))
                    }
                }
            }
            .store(in: &cancellables)
    }

    func setupUI() {
        backgroundColor = Colors.neutralBackgroundLight.color
    }

    func setupLayout() {
        configureCollectionView()
    }

    func configureCollectionView() {
        let configuration = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            listConfiguration.headerMode = .supplementary
            let sectionConfiguration = NSCollectionLayoutSection.list(
                using: listConfiguration,
                layoutEnvironment: layoutEnvironment
            )
            return sectionConfiguration
        }

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configuration)
        addSubview(collectionView, withEdgeInsets: .zero, safeArea: false)
    }

    func setupDataSource() {
        collectionView.register(cellType: MyInfoCollectionViewCell.self)
        collectionView.register(header: MyStackHeaderView.self)

        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .myInfo(let viewState):
                let cell: MyInfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setViewState(viewState)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  let section = dataSource?.snapshot().sectionIdentifiers[indexPath.section]
            else { return nil }

            let header: MyStackHeaderView = collectionView.dequeueSupplementaryView(for: indexPath, kind: kind)
            header.configure(title: section.headerTitle)

            return header
        }
    }

    func setupSnapshot(sections: [SectionModel<MyStackSection, MyStackRow>]) {
        var snapshot = NSDiffableDataSourceSnapshot<MyStackSection, MyStackRow>()
        for model in sections {
            snapshot.appendSections([model.section])
            snapshot.appendItems(model.items, toSection: model.section)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
