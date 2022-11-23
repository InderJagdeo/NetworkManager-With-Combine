//
//  NetworkConstant.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Foundation

var kTimeoutInterval: TimeInterval = 30.0
var kNetworkEnvironment: Environment = .development
var kRequestCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData

enum ApiVersion: String {
    case v3 = "v3.1"
}

enum ApiEndPoint: String {
    case all = "all"
}


