//
//  ImageCarouselView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 14/11/2025.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

final class ImageCarouselView: BaseView {
    // MARK: - Subviews
    private var collectionView: UICollectionView!
    
    // MARK: - DataSource
    private var dataSource: ImageCarouselDiffableDataSource?
    private var snapshot = NSDiffableDataSourceSnapshot<ImageCarouselSection, ImageCarouselRow>()
    
    // MARK: - Tap publisher
    private(set) lazy var imageTapPublisher = imageTapSubject.eraseToAnyPublisher()
    private let imageTapSubject = PassthroughSubject<IndexPath, Never>()
    
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
extension ImageCarouselView {
    func setViewState(_ viewState: ViewState) {
        setupSnapshot(sections: viewState.sectionModel)
    }
    
    struct ViewState {
        let sectionModel: [SectionModel<ImageCarouselSection, ImageCarouselRow>]
    }
}

// MARK: - Private extenison
private extension ImageCarouselView {
    func initialSetup() {
        configureCollectionView()
        setupDataSource()
        setupUI()
        setupBindings()
    }
    
    func setupUI() {
        backgroundColor = .clear
    }
    
    func setupBindings() {
        collectionView.didSelectItemPublisher
            .subscribe(imageTapSubject)
            .store(in: &cancellables)
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
            
            let sections = dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch sections {
            case .imagesSection:
                return createdImagesSectionLayout()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createdImagesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func setupDataSource() {
        collectionView.register(cellType: CarouselCollectionViewCell.self)
        
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .image(let url):
                    let cell: CarouselCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.setImageUrl(url)
                    return cell
                }
            })
    }
    
    func setupSnapshot(sections: [SectionModel<ImageCarouselSection, ImageCarouselRow>]) {
        for section in sections {
            snapshot.appendSections([section.section])
            snapshot.appendItems(section.items, toSection: section.section)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
