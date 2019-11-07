//
//  NetworkSession.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Alamofire

public protocol NetworkSession {
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

final class DefaultNetworkSession: NetworkSession {
    func loadData(from request: URLRequest,
                  completion: @escaping (Data?, Error?) -> Void) {
        Alamofire
            .request(request)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { response in
                guard response.result.isSuccess else {
                    completion(nil,response.result.error)
                    return
                }
                completion(response.data, nil)
            })
        
    }
}
