//
//  CurrencyRepository.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

final class DefaultCurrencyRepository {
    private let service: NetworkService
    private let currenciesStorage: CurrenciesStorage
    init(networkService: NetworkService, currenciesStorage: CurrenciesStorage) {
        self.service = networkService
        self.currenciesStorage = currenciesStorage
    }
}

extension DefaultCurrencyRepository: CurrencyRepository {
    func getCurrency(from: String,
                     to: String,
                     completion: @escaping (Result<String, Error>) -> Void
    ){
        service.request(endpoint: CurrencyEndpoint.exchangeRates(from, to)) { (result) in
            switch result {
            case .success(let course):
                completion(.success(course))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveCurrency(currency: [Currency]) {
        currenciesStorage.createObject(currency: currency)
    }
    
    func getCurrencyFromTheBase() -> [Currency] {
        return currenciesStorage.getCurrencies()
    }
    
    func remove(currency: Currency) {
        currenciesStorage.remove(currency: currency)
    }
}
