//
//  RealmStorage.swift
//  Currencies
//
//  Created by unostraniero on 08.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CurrencyObject: Object {
    @objc dynamic var currency: String = ""
    @objc dynamic var from: String = ""
    @objc dynamic var rates: String = ""
    @objc dynamic var fromRates: String = ""
    
    //т.к. апи дает выбирать базовую валюту только евро, можно сделать ключем конвертируемую валюту(для нашего случая она всегда уникальна)
    override static func primaryKey() -> String? {
        return "fromRates"
    }
}

class CurrenciesStorage {
    var realm: Realm { return try! Realm() }
    
    func createObject(currency: [Currency]) {
        let currentCurrency = currency.map { createCurrencyObject(currency: $0) }
        try! realm.write {
            realm.add(currentCurrency,update: .modified)
        }
    }
    
    private func createCurrencyObject(currency: Currency) -> CurrencyObject {
        let currentCurrency = CurrencyObject()
        currentCurrency.currency = currency.currency
        currentCurrency.from = currency.from
        currentCurrency.fromRates = currency.fromRates
        currentCurrency.rates = currency.rates
        return currentCurrency
    }
    
    func getCurrencies() -> [Currency] {
        let object = realm.objects(CurrencyObject.self)
        let currencies: [Currency] = object.map{ Currency(currency: $0.currency,
                                              from: $0.from,
                                              rates: $0.rates,
                                              fromRates: $0.fromRates)
        }
        return currencies.reversed()
    }
    
    func remove(currency: Currency) {
        let object = realm.objects(CurrencyObject.self)
        try! realm.write {
            realm.delete(object.filter("fromRates == \"\(currency.fromRates)\""))
        }
    }
}
