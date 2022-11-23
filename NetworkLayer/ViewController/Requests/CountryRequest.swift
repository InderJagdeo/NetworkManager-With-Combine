//
//  Country.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Foundation
import UIKit

struct CountryRequest: Router {
    var path: String = "/\(ApiVersion.v3.rawValue)/" + EndPoint.all.rawValue
    var method: HTTPMethod = .get
    var requestType: RequestType = .data
    var parameters: RequestParameters?
    typealias Response = [Country]
}
