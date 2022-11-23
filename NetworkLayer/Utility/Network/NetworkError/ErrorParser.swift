//
//  NetworkErrorMapper.swift
//  NetworkLayer
//
//  Created by Macbook on 23/11/22.
//

import Foundation

public protocol ErrorParserType {
    func parse(_ error: ErrorHandler) -> Error

}

struct ErrorParser: ErrorParserType {

    func parse(_ error: ErrorHandler) -> Error {
         switch error {
         case .mapNetworkError(let statusCode):
             switch statusCode {
             case 400: return RequestError.invalidRequest(statusCode)
             case 401: return RequestError.unauthorized(statusCode)
             case 403: return RequestError.forbidden(statusCode)
             case 404: return RequestError.notFound(statusCode)
             case 402, 405...599: return RequestError.serverError(statusCode)
             default: return RequestError.unknown(nil, ErrorMessage.unknowError.rawValue)
             }
         case .handleNetworkError(let error):
             switch error {
             case is Swift.DecodingError:
                 return RequestError.invalidResponse(error)
             case let urlError as URLError:
                 return RequestError.invalidURL(urlError)
             case let error as RequestError:
                 return error
             default:
                 return RequestError.unknown(error)
             }
         }
    }
}

public enum ErrorHandler {
    case mapNetworkError(_ statusCode: Int)
    case handleNetworkError(_ error: Error)
}
