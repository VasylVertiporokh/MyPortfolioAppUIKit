//
//  SectionModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Foundation

struct SectionModel<Section: Hashable, Item: Hashable> {
    let section: Section
    var items: [Item]
}
