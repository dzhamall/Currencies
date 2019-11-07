//
//  FirstCurrencyPresenter.swift
//  Currencies
//
//  Created by unostraniero on 07.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

public protocol CurrencyPresenterDelegate: class {
    func showNextCurrencyScene(from: String)
    func showRatesScene(from: String, to: String)
}

enum RouteCurrencyPresenter {
    case firstScene
    case secondScene
}

final class CurrencyPresenter<View: ViewProtocol> where View.DataType == CurrencyType {
    
    private weak var currentView: View?
    private weak var delegate: CurrencyPresenterDelegate? 
    private var router: RouteCurrencyPresenter
    private var fromCurrency: String?
    
    init(delegate: CurrencyPresenterDelegate,
         router: RouteCurrencyPresenter,
         fromCurrency: String?
    ) {
        self.delegate = delegate
        self.router = router
        self.fromCurrency = fromCurrency
    }
    
    private func handler() {
        switch router {
        case .firstScene:
            self.currentView?.setData(data: CurrencyType(showNextCurrencyScene: {[weak self] currency in
                guard let strongSelf = self else { return }
                strongSelf.delegate?.showNextCurrencyScene(from: currency)
            }))
        case .secondScene:
            self.currentView?.setData(data: CurrencyType(showNextCurrencyScene:{[weak self] (currency) in
                guard let strongSelf = self else { return }
        
                strongSelf.delegate?.showRatesScene(from: strongSelf.fromCurrency!, to: currency)
            }))
        }
        
    }
}

extension CurrencyPresenter: PresenterProtocol {
    typealias ViewType = View
    
    func actionHadling(view: View) {}
    
    func attachView(view: View) {
        self.currentView = view
        self.handler()
    }
    
    func detachView() {
//        self.currentView = nil
    }
    
}

struct CurrencyType {
    var showNextCurrencyScene: ((String) -> Void)
}
