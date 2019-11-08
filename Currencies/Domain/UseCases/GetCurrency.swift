//
//  GetCurrencies.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

public protocol GetCurrencyUseCase: class {
    func execute(from: String, to: String, completion: @escaping (Result<String,Error>) -> Void)
    func fetch() -> [Currency]
    func remove(currency: Currency)
    func saveCurrency(currency: [Currency])
}

final class DefaultGetCurrencyUseCase{
    private let currencyRepository: CurrencyRepository
    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
}

extension DefaultGetCurrencyUseCase: GetCurrencyUseCase {
    func execute(from: String, to: String, completion: @escaping (Result<String, Error>) -> Void) {
        currencyRepository.getCurrency(from: from, to: to) { result in
            switch result {
            case .success(let rates):
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }
    
    func fetch() -> [Currency] {
        return currencyRepository.getCurrencyFromTheBase()
    }
    
    func remove(currency: Currency) {
        
    }
    
    func saveCurrency(currency: [Currency]) {
        currencyRepository.saveCurrency(currency: currency)
    }
    
    private func saveCurrency(from: String, to: String, rates: String) {
        let currency = Currency(currency: from,
                                from: currenciesDictionary["\(from)"]!,
                                rates: rates,
                                fromRates: currenciesDictionary["\(to)"]!)
        currencyRepository.saveCurrency(currency: [currency])
    }
}
