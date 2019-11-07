//
//  NetworkService.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol Network {
    func request(endpoint: Endpoint, completion: @escaping (ResponseResult) -> Void)
}

final class NetworkService: Network {
    
    private var session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func request(endpoint: Endpoint, completion: @escaping (ResponseResult) -> Void) {
        guard let request = endpoint.urlRequest else { return }

        session.loadData(from: request) { (data, error) in
            
            guard error == nil else {
                
                //MARK: - Response Error Handling
                guard Connectivity.isConnectedToInternet() else {
                    completion(.failure("нет интернет соединения"))
                    return
                }
                
                guard let error = error as? AFError else { return }
                switch error {
                case .invalidURL(let url):
                    completion(.failure("не действительный URL"))
                    print(" URL: \(url) - \(error.localizedDescription)")
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                case .responseValidationFailed(let reason):
                    print("Response validation failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                    
                    switch reason {
                    case .unacceptableStatusCode(let code):
                        guard code >= 500 else { return }
                        completion(.failure(" Неизвестная ошибка "))
                    default:
                        break
                    }
                    
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription)")
                    print("Failure Reason: \(reason)")
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(" Неизвестная ошибка "))
                return
            }
            do {
                let json = try JSON(data: data)
                let result = json["rates"]["\(endpoint.currency)"].stringValue
                
                guard result != "" else {
                    let js = json["error"]["code"]
                    let error = self.errorHandling(code: Int(js.description)!)
                    completion(.failure(error))
                    return
                }
    
                completion(.success(result))
            } catch { fatalError() }
        }
    }
}

public class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


//MARK: - Api Error Handling
extension NetworkService {
    private func errorHandling(code: Int) -> String {
        switch code {
        case 105:
            return " При данной подписке, базовая валюта только EUR"
        case 404:
            return "The requested resource does not exist."
        case 104:
            return "The maximum allowed API amount of monthly API requests has been reached."
        case 101:
            return "No API Key was specified or an invalid API Key was specified."
        case 103:
            return "The requested API endpoint does not exist."
        default:
            return " ошибка на сервере "
        }
    }
}
