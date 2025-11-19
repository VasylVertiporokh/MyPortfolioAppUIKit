//
//  ImageCarouselDiffableDataSource.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 16/11/2025.
//

import UIKit

// MARK: - ImageCarouselSection
enum ImageCarouselSection: Hashable {
    case imagesSection
}

// MARK: - ImageCarouselRow
enum ImageCarouselRow: Hashable {
    case image(URL)
}


final class ImageCarouselDiffableDataSource: UICollectionViewDiffableDataSource<ImageCarouselSection, ImageCarouselRow> {
    // MARK: - Init
    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<ImageCarouselSection, ImageCarouselRow>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}
