//
//  UITableView+Extansion.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit

extension UITableView {
    // MARK: - Cell Registration and Dequeuing
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }

    func register<C: UITableViewCell>(cellType: C.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.className)
    }

    // MARK: - Header/Footer View Registration and Dequeuing
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("Could not dequeue HeaderFooterView with identifier \(T.className)")
        }
        return view
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.className)
    }
}
