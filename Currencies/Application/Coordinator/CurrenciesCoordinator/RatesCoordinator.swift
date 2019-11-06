//
//  RatesCoordinator.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class RatesCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension RatesCoordinator: Coordinator {
    func start() {
        let scene = CurrenciesFactory.makeRatesView(delegate: self)
        self.navigationController.setViewControllers([scene], animated: true)
    }
}

//MARK: - Delegate
extension RatesCoordinator: RatesDelegate {
    func showNextView() {
        
    }
}
