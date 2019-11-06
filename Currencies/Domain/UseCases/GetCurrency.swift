//
//  GetCurrencies.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

protocol GetCurrencyUseCase: class {
    func execute(from: String, to: String, completion: @escaping (Result<Currency,Error>) -> Void)
}

final class DefaultGetCurrencyUseCase{
    private let currencyRepository: CurrencyRepository
    init(currencyRepository: CurrencyRepository) {
        self.currencyRepository = currencyRepository
    }
}

extension DefaultGetCurrencyUseCase: GetCurrencyUseCase {
    func execute(from: String, to: String, completion: @escaping (Result<Currency, Error>) -> Void) {
        currencyRepository.getCurrency(from: from, to: to) { result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                completion(result)
            }
        }
    }
}
