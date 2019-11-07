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
    
    private weak var currentView: View?
    private weak var delegate: RatesDelegate?
    private var currencyUseCase: GetCurrencyUseCase
        
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
                DispatchQueue.main.async {
                    strongSelf.currentView?.setData(data: nil)
                }
                strongSelf.delegate?.setError(message: error as! String)
            }
        }
    }
    
    func convert() {
        self.currentView?.updateData(data:
            RatesType(setCurrrency: nil,
                      refreshHandling: { [weak self] data in
                        guard let strongSelf = self else { return }
                        var allRates: [String] = [ ]
                        data.forEach { (model) in
                            allRates.append(model.rates)}
                        
                        strongSelf.currencyUseCase.execute(from: "", to: allRates.first!) { (result) in
                            switch result {
                            case .success(let currency):
                                break
                            case .failure(let error):
                                break
                            }
                        }
            })
        )
    
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
