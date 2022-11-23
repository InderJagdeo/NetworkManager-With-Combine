//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Combine
import Foundation
import UIKit

public protocol NetworkRequestProtocol: Any {
    var session: URLSession { get }
    func dataRequest<Route: Router>(_ route: Route) -> AnyPublisher<Route.Response, Error>
}

public final class NetworkRequest: NetworkRequestProtocol {
    public var session: URLSession

    init(_ session: URLSession = .shared) {
        self.session = session
    }

    public convenience init(configuration: URLSessionConfiguration) {
        self.init()
        self.session = URLSession(configuration: configuration)
    }

    public func dataRequest<Route: Router>(_ route: Route) -> AnyPublisher<Route.Response, Error> {
        guard let request = route.request() else {
            return Fail(outputType: Route.Response.self, failure: RequestError.invalidURL()).eraseToAnyPublisher()
        }

        guard NetworkMonitor.shared.isReachable else {
            return Fail(outputType: Route.Response.self, failure: NetworkError.unreachable()).eraseToAnyPublisher()
        }
        return session
            .dataTaskPublisher(for: request)
            .tryMap({ data, response in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw route.errorParser.parse(.mapNetworkError(response.statusCode))
                }
                return data
            })
            .decode(type: Route.Response.self, decoder: JSONDecoder())
            .mapError { error in
                return route.errorParser.parse(.handleNetworkError(error))
            }
            .receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}

