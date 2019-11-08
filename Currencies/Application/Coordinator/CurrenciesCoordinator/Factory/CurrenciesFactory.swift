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
    
    private static var currenciesStorage: CurrenciesStorage = CurrenciesStorage()
    
    //MARK: - Rates View
    static func makeRatesView(delegate: RatesDelegate,
                              from: String?,
                              to: String?
    ) -> ViewController<RatesTableView,RatesPresenter<RatesTableView>> {
        let presenter = RatesPresenter<RatesTableView>(delegate: delegate,
                                                       currencyUseCase: makeCurrencyUseCase())
        presenter.updateAndShow(from: from, to: to)
        return ViewController(currentView: RatesTableView(), presenter: presenter, titleName: "Rates")
    }
    
    private static func makeCurrencyUseCase() -> GetCurrencyUseCase {
        return DefaultGetCurrencyUseCase(currencyRepository: makeCurrencyRepository())
    }
    
    private static func makeCurrencyRepository() -> CurrencyRepository {
        return DefaultCurrencyRepository(networkService: networkService,
                                         currenciesStorage: currenciesStorage)
    }
    
    //MARK: - First Currency View
    static func makeFirstCurrencyView(titleName: String,
                                      delegate: CurrencyPresenterDelegate,
                                      useCase: GetCurrencyUseCase?
    ) -> ViewController<NextCurrencyTableView, CurrencyPresenter<NextCurrencyTableView>> {
        
        let presenter = CurrencyPresenter<NextCurrencyTableView>(delegate: delegate,
                                                                 router: .firstScene,
                                                                 fromCurrency: nil)
        return ViewController(currentView:NextCurrencyTableView(),
                              presenter: presenter, titleName: titleName)
        
    }
    
    static func makeSecondCurrencyView(titleName: String,
                                       delegate: CurrencyPresenterDelegate,
                                       fromCurrency: String
    ) -> ViewController<NextCurrencyTableView, CurrencyPresenter<NextCurrencyTableView>> {
        
        let presenter = CurrencyPresenter<NextCurrencyTableView>(delegate: delegate,
                                                                 router: .secondScene,
                                                                 fromCurrency: fromCurrency)
        return ViewController(currentView:NextCurrencyTableView(),
                              presenter: presenter,
                              titleName: titleName)
        
    }
}
