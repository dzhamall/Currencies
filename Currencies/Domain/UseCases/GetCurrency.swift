//
//  GetCurrencies.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

protocol GetCurrency {
    func execute(completion: @escaping (Result<Currency,Error>) -> Void)
}

final class DefaultGetCurrency{
    private let currencyRepository: CurrencyRepository
    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
}

extension DefaultGetCurrency: GetCurrency {
    func execute(completion: @escaping (Result<Currency, Error>) -> Void) {
        currencyRepository.getCurrency { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }
}
