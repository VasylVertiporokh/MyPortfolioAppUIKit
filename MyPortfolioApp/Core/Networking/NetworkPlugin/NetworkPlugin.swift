//
//  NetworkPlugin.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

protocol NetworkPlugin {
    func modifyRequest(_ request: inout URLRequest)
}
