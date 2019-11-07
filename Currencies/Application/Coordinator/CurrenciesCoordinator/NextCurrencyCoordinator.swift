//
//  FirstCurrencyCoordinator.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import UIKit

final class NextCurrencyCoordinator {
    
    private let navigationController: UINavigationController
    private weak var ratesCoordinator: RatesCoordinator?
    
    init(navigationController: UINavigationController, ratesCoordinator: RatesCoordinator){
        self.navigationController = navigationController
        self.ratesCoordinator = ratesCoordinator
    }
}

extension NextCurrencyCoordinator: Coordinator {
    func start() {
        let scene = CurrenciesFactory.makeFirstCurrencyView(titleName: "First currency",
                                                            delegate: self,
                                                            useCase: nil)
        self.navigationController.pushViewController(scene, animated: true)
    }
}

//MARK: - Delegate
extension NextCurrencyCoordinator: CurrencyPresenterDelegate {
    func showNextCurrencyScene(from: String) {
        let scene = CurrenciesFactory.makeSecondCurrencyView(titleName: "Second currency",
                                                             delegate: self,
                                                             fromCurrency: from)
        self.navigationController.pushViewController(scene, animated: true)
    }
    
    func showRatesScene(from: String, to: String) {
        ratesCoordinator?.updateAndShow(from: from, to: to)
    }
}
