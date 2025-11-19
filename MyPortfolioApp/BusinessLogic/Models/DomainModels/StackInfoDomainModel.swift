//
//  StackInfoDomainModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 18/11/2025.
//

import Foundation

struct StackInfoDomainModel {
    var stackSections: [Section] = []

    struct Section {
        var id: String = ""
        var kind: MyStackSection.Kind = .main
        var header: String = ""
        var parent: Item
        var children: [Item]
    }

    struct Item {
        let title: String
        let imageUrl: URL?
    }
}
