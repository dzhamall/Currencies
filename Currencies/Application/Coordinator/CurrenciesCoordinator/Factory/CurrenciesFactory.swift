//
//  CurrenciesFactory.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

final class CurrenciesFactory {
    
    private static var networkService: NetworkService = {
        let networkSession = DefaultNetworkSession()
        let service = NetworkService(session: networkSession)
        return service
    }()
    
    static func makeRatesView(delegate: RatesDelegate
    ) -> ViewController<RatesTableView,RatesPresenter<RatesTableView>> {
        let presenter = RatesPresenter<RatesTableView>(delegate: delegate,
                                                       currencyUseCase: makeCurrencyUseCase())
        return ViewController(currentView: RatesTableView(), presenter: presenter)
    }
    
    private static func makeCurrencyUseCase() -> GetCurrencyUseCase {
        return DefaultGetCurrencyUseCase(currencyRepository: makeCurrencyRepository())
    }
    
    private static func makeCurrencyRepository() -> CurrencyRepository {
        return DefaultCurrencyRepository(networkService: networkService)
    }
    
    
}
