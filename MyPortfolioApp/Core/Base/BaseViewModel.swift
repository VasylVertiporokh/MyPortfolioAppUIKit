//
//  BaseViewModel.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import Combine

/// A protocol defining the required interface for all ViewModels used
/// with `BaseViewController`.
///
/// ViewModels conforming to this protocol must:
/// - expose loading and error publishers
/// - handle lifecycle events forwarded from the view controller
protocol ViewModel {

    /// A publisher that emits `true` when a loading state begins
    /// and `false` when it ends.
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }

    /// A publisher that emits errors which should be displayed to the user.
    var errorPublisher: AnyPublisher<Error, Never> { get }

    /// Called when the associated view controller triggers `viewDidLoad`.
    func onViewDidLoad()

    /// Called when the associated view controller triggers `viewWillAppear`.
    func onViewWillAppear()

    /// Called when the associated view controller triggers `viewDidAppear`.
    func onViewDidAppear()

    /// Called when the associated view controller triggers `viewWillDisappear`.
    func onViewWillDisappear()

    /// Called when the associated view controller triggers `viewDidDisappear`.
    func onViewDidDisappear()
}

/// A base implementation of `ViewModel` providing:
/// - lifecycle event stubs,
/// - loading and error publishers,
/// - Combine cancellables storage.
///
/// Subclasses can extend this to add screen-specific logic.
class BaseViewModel: ViewModel {

    /// A set of Combine cancellables used to store subscriptions.
    var cancellables = Set<AnyCancellable>()

    /// Public publisher exposing the loading state.
    private(set) lazy var isLoadingPublisher = isLoadingSubject.eraseToAnyPublisher()

    /// Internal subject that controls the loading state.
    let isLoadingSubject = CurrentValueSubject<Bool, Never>(false)

    /// Public publisher exposing errors emitted by the ViewModel.
    private(set) lazy var errorPublisher = errorSubject.eraseToAnyPublisher()

    /// Internal subject used to publish errors.
    let errorSubject = PassthroughSubject<Error, Never>()

    /// Logs the deinitialization of the ViewModel for debugging purposes.
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }

    // MARK: - Lifecycle Methods

    /// Default empty implementation for subclasses to override.
    func onViewDidLoad() {}

    /// Default empty implementation for subclasses to override.
    func onViewWillAppear() {}

    /// Default empty implementation for subclasses to override.
    func onViewDidAppear() {}

    /// Default empty implementation for subclasses to override.
    func onViewWillDisappear() {}

    /// Default empty implementation for subclasses to override.
    func onViewDidDisappear() {}
}
