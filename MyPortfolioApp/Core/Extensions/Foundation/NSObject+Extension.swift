//
//  NSObject+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
