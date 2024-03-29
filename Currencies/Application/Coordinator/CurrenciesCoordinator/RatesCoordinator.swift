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
    private var firstCurrencyView: NextCurrencyCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func updateAndShow(from: String?, to: String?) {
        let scene = CurrenciesFactory.makeRatesView(delegate: self, from: from, to: to)
        self.navigationController.setViewControllers([scene], animated: true)
    }

}

extension RatesCoordinator: Coordinator {
    func start() {
        let scene = CurrenciesFactory.makeRatesView(delegate: self, from: nil, to: nil)
        self.navigationController.setViewControllers([scene], animated: true)
    }
}

//MARK: - Delegate
extension RatesCoordinator: RatesDelegate {
    func setError(message: String) {
        self.reportAnErrorInAlert(message: message)
    }

    func showNextView() {
        let firstCurrencyView = NextCurrencyCoordinator(navigationController: navigationController,
                                                         ratesCoordinator: self)
        self.firstCurrencyView = firstCurrencyView
        self.firstCurrencyView?.start()
    }
}

//MARK: - Error Protocol
extension RatesCoordinator: ErrorProtocol {
    func reportAnErrorInAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.navigationController.present(alert, animated: true, completion: nil)
        }
    }
}
