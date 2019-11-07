//
//  File.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

var currArray: [RatesModel] = []

protocol RatesDelegate: class {
    func showNextView(useCase: GetCurrencyUseCase)
}

final class RatesPresenter<View: ViewProtocol> where View.DataType == RatesType {
    
    private weak var currentView: View?
    private weak var delegate: RatesDelegate?
    private var currencyUseCase: GetCurrencyUseCase
        
    init(delegate: RatesDelegate, currencyUseCase: GetCurrencyUseCase) {
        self.delegate = delegate
        self.currencyUseCase = currencyUseCase
    }
    
    func updateAndShow(from: String?, to: String?) {
        guard let fromCurr = from, let toCurr = to else { return }
        currencyUseCase.execute(from: fromCurr, to: toCurr) { (result) in
            switch result {
            case .success(let rates):
                self.currentView?.setData(data: RatesType(
                    setCurrrency: [RatesModel(
                        currency: fromCurr,
                        from: currenciesDictionary["\(fromCurr)"]!,
                        rates: "\(rates)",
                        fromRates: currenciesDictionary["\(toCurr)"]!)]
                    )
                )
            case .failure(let error):
                break
            }
        }
    }
    
    func convert() {
//        currencyUseCase.execute(from: "EUR", to: "RUB") { (result) in
//            switch result {
//            case .success(let currency):
//                break
//            case .failure(let error):
//                break
//            }
//        }
    }
    
}

extension RatesPresenter: PresenterProtocol {
    typealias ViewType = View
    
    func attachView(view: View) {
        self.currentView = view
        convert()
    }
    
    func detachView() {
        self.currentView = nil
    }
    
    func actionHadling(view: View) {
        self.delegate?.showNextView(useCase: self.currencyUseCase)
    }
}

struct RatesType {
    var setCurrrency: [RatesModel]
}
