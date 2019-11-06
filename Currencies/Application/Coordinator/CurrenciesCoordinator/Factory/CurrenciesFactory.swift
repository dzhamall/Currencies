//
//  CurrenciesFactory.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

final class CurrenciesFactory {
    
    static func makeRatesView(delegate: RatesDelegate) -> ViewController<RatesTableView,RatesPresenter<RatesTableView>> {
        let presenter = RatesPresenter<RatesTableView>(delegate: delegate)
        return ViewController(currentView: RatesTableView(), presenter: presenter)
    }
    
    
}
