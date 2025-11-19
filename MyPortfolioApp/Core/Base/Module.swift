//
//  Module.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

/// A marker protocol representing navigation transitions emitted by modules.
///
/// Types conforming to this protocol define the possible navigation actions
/// a module can instruct its coordinator to perform.
protocol Transition {}

/// Represents a complete module consisting of:
/// - a view controller to be displayed,
/// - a publisher that emits navigation transitions handled by a coordinator.
///
/// This allows coordinators to react to user actions without the view controller
/// knowing about navigation logic.
struct Module<T: Transition, V: UIViewController> {

    /// The view controller associated with the module.
    let viewController: V

    /// A publisher emitting navigation transitions defined by the module's `Transition` type.
    let transitionPublisher: AnyPublisher<T, Never>
}
