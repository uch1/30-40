//
//  Resource.swift
//  RememberThis
//
//  Created by Uchenna  Aguocha on 11/22/17.
//  Copyright © 2017 Uchenna  Aguocha. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

enum Resource {
    
    case results
    
    func httpMethod() -> HTTPMethods {
        switch self {
        case .results:
            return .get
        }
    }
    
    func path() -> String {
        switch self {
        case .results:
            return "1.1/?results=5" // /1.1
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .results:
            return [:]
        }
    }
    
    func body() -> Data? {
        switch self {
        case .results:
            return nil
        }
    }
    
}
