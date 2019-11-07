//
//  CurrencyRepository.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

protocol CurrencyRepository {
    func getCurrency(from: String, to: String, completion: @escaping (Result<String, Error>) -> Void)
}
