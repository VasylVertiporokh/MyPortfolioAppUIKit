//
//  BaseView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import CombineCocoa

/// A base `UIView` subclass that provides shared functionality for all custom views,
/// including a container for Combine cancellables used to manage subscriptions.
class BaseView: UIView {

    /// A set of Combine cancellables used to store and manage subscriptions
    /// during the view’s lifecycle.
    var cancellables = Set<AnyCancellable>()
}
