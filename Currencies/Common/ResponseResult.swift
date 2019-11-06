//
//  ResponseResult.swift
//  Currencies
//
//  Created by unostraniero on 06.11.2019.
//  Copyright © 2019 unostraniero. All rights reserved.
//

import Foundation

public enum ResponseResult {
    case success(String)
    case failure(String)
}

extension String: Error { }
