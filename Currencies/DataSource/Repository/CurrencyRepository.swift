//
//  CurrencyRepository.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

final class DefaultCurrencyRepository {
    let service: NetworkService
    init(networkService: NetworkService) {
        self.service = networkService
    }
}

extension DefaultCurrencyRepository: CurrencyRepository {
    func getCurrency(from: String,
                     to: String,
                     completion: @escaping (Result<Currency, Error>) -> Void
    ){
        service.request(endpoint: CurrencyEndpoint.exchangeRates(from, to)) { (result) in
            switch result {
            case .success(let course):
                completion(.success(Currency(convert: course)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
