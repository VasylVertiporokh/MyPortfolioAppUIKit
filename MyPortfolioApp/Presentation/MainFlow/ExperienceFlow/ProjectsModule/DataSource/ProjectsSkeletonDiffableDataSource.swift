//
//  ProjectsSkeletonDiffableDataSource.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 13/11/2025.
//

import UIKit
import SkeletonView


// MARK: - ProjectsSection
enum ProjectsSection: Hashable {
    case projects
}

// MARK: - ProjectRow
enum ProjectRow: Hashable {
    case projectRow(ProjectCollectionViewCell.ViewState)

    func extract() -> ProjectCollectionViewCell.ViewState {
          switch self {
          case .projectRow(let value):
              return value
          }
      }
}

final class ProjectsSkeletonDiffableDataSource:
    UICollectionViewDiffableDataSource<ProjectsSection, ProjectRow>,
    SkeletonCollectionViewDataSource {

    // MARK: - Internal properties
    private(set) var skeletonSnapshot = NSDiffableDataSourceSnapshot<ProjectsSection, ProjectRow>()

    // MARK: - Private properties
    private let skeletonItemsCount = 6

    // MARK: - Init
    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<ProjectsSection, ProjectRow>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
        self.skeletonSnapshot.appendSections([.projects])
    }

    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return skeletonSnapshot.numberOfSections
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skeletonItemsCount
    }

    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return ProjectCollectionViewCell.className
    }
}
