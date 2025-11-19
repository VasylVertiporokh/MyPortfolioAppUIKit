//
//  FakeSplashView.swift
//  MyPortfolioApp
//
//  Created by Vasia Vertiporoh on 11/11/2025.
//

import UIKit
import Combine

enum FakeSplashViewAction {
    case spalshAnimationFinished
}

final class FakeSplashView: BaseView {
    // MARK: - Subviews
    private let logoImageView = UIImageView()

    // MARK: - Publishers
    private(set) lazy var actionPublisher = actionSubject.eraseToAnyPublisher()
    private let actionSubject = PassthroughSubject<FakeSplashViewAction, Never>()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        startAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private extenison
private extension FakeSplashView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupUI() {
        backgroundColor = .white
        logoImageView.image = Assets.appLogo.image
        logoImageView.contentMode = .scaleAspectFit
    }

    func setupLayout() {
        addSubviewToCenter(logoImageView, width: 200, height: 200)
    }

    func startAnimation() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 1.0
        pulse.toValue = 1.5
        pulse.duration = 0.33
        pulse.autoreverses = true
        pulse.repeatCount = 3
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulse.delegate = self

        logoImageView.layer.add(pulse, forKey: "pulse")
    }
}

extension FakeSplashView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        actionSubject.send(.spalshAnimationFinished)
    }
}
