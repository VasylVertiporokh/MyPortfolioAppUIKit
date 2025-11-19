//
//  NetworkPlugin.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 12/11/2025.
//

import Foundation

/// A plugin protocol that allows modification of outgoing `URLRequest` objects
/// before they are executed by the networking layer.
///
/// Conforming types can inject headers, authentication tokens, logging,
/// or apply any other request transformation.
protocol NetworkPlugin {

    /// Modifies the given request before it is sent.
    ///
    /// - Parameter request: The request to modify. Provided as `inout` so the plugin
    ///                      can directly mutate the original request instance.
    func modifyRequest(_ request: inout URLRequest)
}
