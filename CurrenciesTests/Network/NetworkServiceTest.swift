//
//  NetworkServiceTest.swift
//  CurrenciesTests
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import XCTest
import Currencies
@testable import Currencies

class NetworkServiceTest: XCTestCase {

    func test_whenMockDataPassed_shouldReturnProperResponse() {
        let data = #"{"rub": 70}"#.data(using: .utf8)
        let expectation = self.expectation(description: "Should return correct data")
        let networkSession = NetworkSessionMock(data: data,
                                                error: nil)
        let networkService = NetworkService(session: networkSession)
        networkService.request(endpoint: EndpointMock.exchangeRates("","")) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    

}
