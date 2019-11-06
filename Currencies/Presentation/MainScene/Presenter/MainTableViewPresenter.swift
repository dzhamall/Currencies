//
//  File.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

protocol RatesDelegate: class {
    func showNextView()
}

final class RatesPresenter<View: ViewProtocol> where View.DataType == RatesType {
    
    private weak var currentView: View?
    private weak var delegate: RatesDelegate?
        
    init(delegate: RatesDelegate) {
        self.delegate = delegate
    }
    
}

extension RatesPresenter: PresenterProtocol {
    typealias ViewType = View
    
    func attachView(view: View) {
        self.currentView = view
    }
    
    func detachView() {
        self.currentView = nil
    }
    
    func actionHadling(view: View) {
        self.delegate?.showNextView()
    }
}

struct RatesType {
    var addCell: Bool
}
