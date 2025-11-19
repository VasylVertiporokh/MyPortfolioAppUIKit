//
//  BaseViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import CombineCocoa

/// A generic base view controller that integrates a `ViewModel` and provides
/// shared lifecycle handling, error presentation, and loading state management.
///
/// Subclasses inherit automatic bindings to:
/// - `isLoadingPublisher` for showing/hiding a loading view
/// - `errorPublisher` for presenting error alerts
/// - ViewModel lifecycle events (`onViewDidLoad`, `onViewWillAppear`, etc.)
class BaseViewController<VM: ViewModel>: UIViewController {

    // MARK: - Internal properties

    /// The view model associated with this view controller.
    /// It provides state, logic, and publishers for UI updates.
    var viewModel: VM

    /// A set of Combine cancellables used to manage subscriptions.
    var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// Initializes a view controller with a given view model.
    /// - Parameter viewModel: The view model that controls this screen's logic.
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// Not supported. This view controller must be initialized programmatically.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    /// Called after the controller's view is loaded into memory.
    /// Sets up bindings to loading and error publishers, and forwards
    /// the lifecycle event to the view model.
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()

        // Bind loading state handling
        viewModel.isLoadingPublisher
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoadingView() : self?.hideLoadingView()
            }
            .store(in: &cancellables)

        // Bind error presentation
        viewModel.errorPublisher
            .sink { [weak self] error in
                let alertController = UIAlertController(
                    title: Localization.Genaral.error,
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(
                    title: Localization.Genaral.ok,
                    style: .default,
                    handler: nil
                )
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
            .store(in: &cancellables)
    }

    /// Forwards lifecycle event to the view model.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }

    /// Forwards lifecycle event to the view model.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }

    /// Forwards lifecycle event to the view model.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onViewWillDisappear()
    }

    /// Forwards lifecycle event to the view model.
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }

    // MARK: - Deinit

    /// Prints a debug message when the instance is deallocated.
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }
}

// MARK: - Internal extension

extension BaseViewController {

    /// Displays a full-screen loading view over the application's main window.
    func showLoadingView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        if let loadingView = window.viewWithTag(LoadingView.tagValue) as? LoadingView {
            loadingView.isLoading = true
        } else {
            let loadingView = LoadingView(frame: UIScreen.main.bounds)
            window.addSubview(loadingView)
            loadingView.isLoading = true
        }
    }

    /// Removes the existing loading view from the screen, if present.
    func hideLoadingView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        window.viewWithTag(LoadingView.tagValue)?.removeFromSuperview()
    }
}
