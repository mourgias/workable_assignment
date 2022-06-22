//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

class URLSessionNetwork {
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
    
    deinit {
        print("♻️ URLSessionNetwork Deinit")
    }
    
    func performRequest<T: Decodable>() -> AnyPublisher<T, NetworkError> {
        
        var buildURL: URL!
        
        if let url = URL(string: url) {
            buildURL = url
        }
        
        guard buildURL != nil else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: buildURL)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap(handleResponse)
            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError({ error in
//                return error
//            })
            .mapError(handleError)
            .eraseToAnyPublisher()
    }
}

extension URLSessionNetwork {
    
   private func handleResponse(data: Data, response: URLResponse?) throws -> Data {
        if let response = response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
            throw httpError(response.statusCode)
        }
        return data
    }
    
    private func handleError(_ error: Error) -> NetworkError {
        switch error {
        case DecodingError.typeMismatch(_, let context),
            DecodingError.valueNotFound(_, let context),
            DecodingError.keyNotFound(_, let context),
            DecodingError.dataCorrupted(let context):
            return .decodingError(context)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as NetworkError:
            return error
        default:
            return .unknownError
        }
    }
    
    private func httpError(_ statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
}
