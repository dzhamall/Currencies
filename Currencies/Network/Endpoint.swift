//
//  Endpoint.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Alamofire

public protocol Endpoint: URLRequestConvertible {
    var baseURL: URL { get }
    var apiKey: String { get }
    var currency: String { get }
    var urlRequest: URLRequest { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryParameters: Parameters { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }

    var encoding: ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    public func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: queryParameters)
    }
    
}
