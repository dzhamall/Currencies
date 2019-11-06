//
//  AppCoordinator.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var mainCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        mainCoordinator = RatesCoordinator(navigationController: rootViewController)
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        window.rootViewController = rootViewController
        mainCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
