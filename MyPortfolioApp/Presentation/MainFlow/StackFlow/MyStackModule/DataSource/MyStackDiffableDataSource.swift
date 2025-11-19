//
//  MyStackDiffableDataSource.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 19/11/2025.
//

import UIKit

struct MyStackSection: Hashable {
    enum Kind {
        case main
        case skills
        case frameworks
        case network
        case storage
        case additional

        // MARK: - Init from response section kind
        init(kind: StackInfoResponseModel.InfoSectionKind) {
            switch kind {
            case .main:
                self = .main
            case .skills:
                self = .skills
            case .frameworks:
                self = .frameworks
            case .network:
                self = .network
            case .storage:
                self = .storage
            case .additional:
                self = .additional
            }
        }
    }

    let id: UUID = UUID()
    let kind: Kind
    var headerTitle: String
    var isExpanded: Bool = false

    var isExpandable: Bool {
        switch kind {
        case .main, .skills, .frameworks, .network, .storage, .additional:
            true
        }
    }
}

enum MyStackRow: Hashable {
    case myInfo(MyInfoCollectionViewCell.ViewState)
}

final class MyStackDiffableDataSource: UICollectionViewDiffableDataSource<MyStackSection, MyStackRow> {
    // MARK: - Init
    override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<MyStackSection, MyStackRow>.CellProvider) {
        super.init(collectionView: collectionView, cellProvider: cellProvider)
    }
}
