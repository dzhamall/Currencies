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
            guard let strongSelf = self else { return }
            switch result {
            case .success(let rates):
                strongSelf.currentView?.setData(data: RatesType(
                    setCurrrency: [RatesModel(
                        currency: fromCurr,
                        from: currenciesDictionary["\(fromCurr)"]!,
                        rates: "\(rates)",
                        fromRates: currenciesDictionary["\(toCurr)"]!)]
                    )
                )
            case .failure(let error):
                strongSelf.currentView?.setData(data: nil)
                strongSelf.delegate?.setError(message: error as! String)
            }
        }
    }
    
    func convert() {
        self.currentView?.updateData(data: RatesType(refreshHandling: { [weak self] data in
            guard let strongSelf = self else { return }
            data.map { return strongSelf.fetchUpdate(model: $0 )}
        }))
    }
    
    private func fetchUpdate(model: RatesModel) {
        let rates = currencDictionaryBackward["\(model.fromRates)"]
        guard let currency = rates else { return  }
        self.currencyUseCase.execute(from: model.currency, to: currency) { [weak self] (result) in
            switch result {
            case .success(let rates):
                let elem = RatesModel(currency: model.currency,
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
}

struct RatesType {
    var setCurrrency: [RatesModel]?
    var refreshHandling: (([RatesModel]) -> Void)?
}
