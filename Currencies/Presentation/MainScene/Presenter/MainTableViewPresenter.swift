//
//  File.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

var currArray: [RatesModel] = []
var fetchFromStorage = true

protocol RatesDelegate: class {
    func showNextView()
    func setError(message: String)
}

final class RatesPresenter<View: ViewProtocol> where View.DataType == RatesType {
    
    private var currentView: View?
    private weak var delegate: RatesDelegate?
    private var currencyUseCase: GetCurrencyUseCase
    private var items: [RatesModel] = [] {
        didSet {
            self.update()
        }
    }
        
    init(delegate: RatesDelegate, currencyUseCase: GetCurrencyUseCase) {
        self.delegate = delegate
        self.currencyUseCase = currencyUseCase
    }
    
    func updateAndShow(from: String?, to: String?) {
        guard let fromCurr = from, let toCurr = to else { return }
        currencyUseCase.execute(from: fromCurr, to: toCurr) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let rates):
                let rates = [RatesModel(
                    currency: fromCurr,
                    from: currenciesDictionary["\(fromCurr)"]!,
                    rates: "\(rates)",
                    fromRates: currenciesDictionary["\(toCurr)"]!)]
                
                self.currentView?.setData(data: RatesType( setCurrrency: rates))
                
                self.currencyUseCase.saveCurrency(currency: rates.map{ Currency(
                    currency: $0.currency,
                    from: $0.from,
                    rates: $0.rates, fromRates: $0.fromRates)})
                
            case .failure(let error):
                self.currentView?.setData(data: nil)
                self.delegate?.setError(message: error as! String)
            }
        }
    }
    
    func convert() {
        self.currentView?.updateData(data: RatesType(refreshHandling: { [weak self] data in
            guard let self = self else { return }
            data.map { return self.fetchUpdate(model: $0) }
            }, remove:{ [weak self] item in
                guard let self = self else { return }
                self.currencyUseCase.remove(currency:
                    Currency(currency: item.currency,
                             from: item.from,
                             rates: item.rates,
                             fromRates: item.fromRates))
        })
        
        )
    }
    
    private func fetchUpdate(model: RatesModel) {
        let rates = currencDictionaryBackward["\(model.fromRates)"]
        guard let currency = rates else { return  }
        self.currencyUseCase.execute(from: model.currency, to: currency) { [weak self] (result) in
            switch result {
            case .success(let rates):
                let elem = RatesModel(
                    currency: model.currency,
                    from: model.from,
                    rates: rates,
                    fromRates: model.fromRates)
                self?.items.append(elem)
            case .failure(let error):
                self?.delegate?.setError(message: error as! String)
            }
        }
    }
    
    private func update() {
        guard !items.isEmpty else { return }
        self.currentView?.updateData(data: RatesType(setCurrrency: items, refreshHandling: nil))
    }
    
    func setDataFromStorage() {
        guard fetchFromStorage else { return }
        fetchFromStorage = false
        let currencies = currencyUseCase.fetch()
        let result = currencies.map { RatesModel(
            currency: $0.currency,
            from: $0.from,
            rates: $0.rates,
            fromRates: $0.fromRates)
        }
        guard !result.isEmpty else {
            self.currentView?.setData(data: RatesType(setCurrrency: nil, refreshHandling: nil))
            return
        }
        self.currentView?.setData(data: RatesType(setCurrrency: result, refreshHandling: nil))
        fetchFromStorage = false 
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
        self.delegate?.showNextView()
    }
    
    func set() {
        setDataFromStorage()
    }
}

struct RatesType {
    var setCurrrency: [RatesModel]?
    var refreshHandling: (([RatesModel]) -> Void)?
    var remove: ((RatesModel) -> Void)?
}
