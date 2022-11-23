//
//  Environment.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    public var url: String {
        switch self {
        case .development:
            return "https://restcountries.com"
        case .staging:
            return "https://restcountries.com"
        case .production:
            return "https://restcountries.com"
        }
    }
}
