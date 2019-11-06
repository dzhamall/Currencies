//
//  CurrencyEndpoint.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Alamofire

enum CurrencyEndpoint {
    case exchangeRates(String, String)
}

extension CurrencyEndpoint: Endpoint {
    
    var currency: String {
        switch self {
        case .exchangeRates(_, let currency):
            return currency
        }
    }
    
    
    var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            return ""
        }
        return apiKey
    }
    
    var baseURL: URL {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError()
        }
        return URL(string: url)!
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        return ["Cache-Control": "no-cache"]
    }
    
    var queryParameters: Parameters {
        switch self {
        case .exchangeRates(let from, let to):
            return ["access_key": apiKey, "base": "\(from)", "symbols": "\(to)"]
        }
    }
    
    
}
