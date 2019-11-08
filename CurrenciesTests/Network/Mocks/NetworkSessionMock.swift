//
//  NetworkSessionMock.swift
//  CurrenciesTests
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Currencies

struct NetworkSessionMock: NetworkSession {
    let data: Data?
    let error: Error?
    
    func loadData(from request: URLRequest,
                  completion: @escaping (Data?, Error?) -> Void
    ) {
        completion(data, error)
    }
}
