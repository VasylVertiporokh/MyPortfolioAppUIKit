//
//  NSObject+Extension.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

extension NSObject {

    /// Returns the name of the class as a string.
    ///
    /// Useful for logging, debugging, registering cells, or instantiating views
    /// without hard-coding class names.
    static var className: String {
        return String(describing: self)
    }
}
