//
//  UICollectionView+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

extension UICollectionView {

    /// Dequeues a reusable cell of the inferred type using its class name as the reuse identifier.
    ///
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// - Returns: A cell instance of type `T`.
    /// - Note: This method force-casts the cell; ensure correct registration beforehand.
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
    }

    /// Dequeues a reusable supplementary view of the inferred type using its class name as the reuse identifier.
    ///
    /// - Parameters:
    ///   - indexPath: The index path of the supplementary view.
    ///   - kind: The kind of supplementary element (e.g. header or footer).
    /// - Returns: A reusable supplementary view of type `T`.
    /// - Note: This method force-casts the view; ensure correct registration beforehand.
    func dequeueSupplementaryView<T: UICollectionReusableView>(for indexPath: IndexPath, kind: String) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.className, for: indexPath) as! T
    }

    /// Registers a reusable collection view cell using its class name as the reuse identifier.
    ///
    /// - Parameter cellType: The cell class to register.
    func register<C: UICollectionViewCell>(cellType: C.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.className)
    }

    /// Registers a reusable supplementary view using its class name as the reuse identifier.
    ///
    /// - Parameter view: The supplementary view class to register.
    /// - Note: This uses the type’s name as the `kind`, which may not always be intended.
    func register<T: UICollectionReusableView>(view: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: String(describing: view.self),
            withReuseIdentifier: view.className
        )
    }

    /// Registers a reusable header view for collection view sections.
    ///
    /// - Parameter header: The header view class to register.
    func register<T: UICollectionReusableView>(header: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: header.className
        )
    }

    /// Registers a reusable footer view for collection view sections.
    ///
    /// - Parameter footer: The footer view class to register.
    func register<T: UICollectionReusableView>(footer: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: footer.className
        )
    }
}
