//
//  EndpointMock.swift
//  CurrenciesTests
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Currencies
import Alamofire

enum EndpointMock {
    case exchangeRates(String, String)
}

extension EndpointMock: Endpoint {
    var apiKey: String {
        return ""
    }
    
    var currency: String {
        switch self {
        case .exchangeRates(_, let currency):
            return currency
        }
    }
    
   
    var urlRequest: URLRequest {
        return URLRequest(url: baseURL)
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var baseURL: URL {
        let urlString = "URL"
        return URL(string: urlString)!
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var queryParameters: Parameters {
        return [:]
    }
    
}
