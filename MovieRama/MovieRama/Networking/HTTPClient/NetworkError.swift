//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError(DecodingError.Context)
    case urlSessionFailed(_ error: URLError)
    case unknownError
    case badURL
}
