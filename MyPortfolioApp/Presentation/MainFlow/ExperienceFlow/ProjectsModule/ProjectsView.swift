//
//  ProjectsView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import UIKit
import Combine
import CombineCocoa
import SkeletonView

enum ProjectsViewAction {
    case didSelectItem(id: String)
}

final class ProjectsView: BaseView {
    // MARK: - Subviews
    private var collectionView: UICollectionView!
    
    private var dataSource: ProjectsSkeletonDiffableDataSource?
    private var snapshot = NSDiffableDataSourceSnapshot<ProjectsSection, ProjectRow>()
    
    // MARK: - Publishers
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<ProjectsViewAction, Never>()
    
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
extension ProjectsView {
    func setViewState(_ viewState: ViewState) {
        setupSnapshot(sections: viewState.sectionModel)
    }
    
    struct ViewState {
        let sectionModel: [SectionModel<ProjectsSection, ProjectRow>]
    }
}


// MARK: - Private extenison
private extension ProjectsView {
    func initialSetup() {
        configureCollectionView()
        setupDataSource()
        setupLayout()
        setupUI()
        bindActions()
    }
    
    func bindActions() {
        collectionView.didSelectItemPublisher
            .compactMap { [weak self] indexPath in self?.dataSource?.itemIdentifier(for: indexPath)?.extract() }
            .map { ProjectsViewAction.didSelectItem(id: $0.id) }
            .subscribe(actionSubject)
            .store(in: &cancellables)
    }
    
    func setupUI() {
        backgroundColor = Colors.neutralBackgroundLight.color
    }
    
    func setupLayout() {
        
    }
    
    func setupDataSource() {
        collectionView.register(cellType: ProjectCollectionViewCell.self)
        
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .projectRow(let model):
                    let cell: ProjectCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.setViewState(model)
                    return cell
                }
            })
        
        collectionView.isSkeletonable = true
        collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.showAnimatedGradientSkeleton()
    }
    
    func setupSnapshot(sections: [SectionModel<ProjectsSection, ProjectRow>]) {
        for section in sections {
            snapshot.appendSections([section.section])
            snapshot.appendItems(section.items, toSection: section.section)
        }
        collectionView.hideSkeleton()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = backgroundColor
        addSubview(collectionView, withEdgeInsets: .zero, safeArea: false)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment in
            guard let dataSource = dataSource else {
                return nil
            }
            
            let currentSnapshot = collectionView.sk.isSkeletonActive
            ? dataSource.skeletonSnapshot
            : snapshot
            
            let sections = currentSnapshot.sectionIdentifiers[sectionIndex]
            switch sections {
            case .projects:
                return createdProjectsSectionLayout()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createdProjectsSectionLayout() -> NSCollectionLayoutSection {
        let sideInset: CGFloat = 16
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(280)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]
        )
        group.interItemSpacing = .fixed(8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sideInset,
            bottom: 0,
            trailing: sideInset
        )
        section.interGroupSpacing = 8
        return section
    }
}
