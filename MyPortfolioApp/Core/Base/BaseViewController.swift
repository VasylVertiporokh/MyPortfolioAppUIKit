//
//  BaseViewController.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine
import CombineCocoa

class BaseViewController<VM: ViewModel>: UIViewController {
    // MARK: - Internal proeprties
    var viewModel: VM
    var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()

        viewModel.isLoadingPublisher
            .sink { [weak self] isLoading in
                isLoading ? self?.showLoadingView() : self?.hideLoadingView()
            }
            .store(in: &cancellables)

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onViewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onViewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.onViewWillDisappear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.onViewDidDisappear()
    }

    // MARK: - Deinit
    deinit {
        debugPrint("deinit of ", String(describing: self))
    }
}

// MARK: - Internal extension
extension BaseViewController {
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

    func hideLoadingView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        window.viewWithTag(LoadingView.tagValue)?.removeFromSuperview()
    }
}
