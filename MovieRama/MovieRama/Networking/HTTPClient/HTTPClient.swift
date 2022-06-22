//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

typealias APIResponse<T> = AnyPublisher<T, NetworkError>

let baseImageURLw500: String = "https://image.tmdb.org/t/p/w500"

class HTTPClient {
    
    static let shared = HTTPClient()
    
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "&api_key=30842f7c80f80bb3ad8a2fb98195544d"
    private var language = "&language=en-US"
    
    // ----- Second approach
    
    func getRequest<T: Decodable>(_ router: Router) -> AnyPublisher<T, NetworkError> {
        
        let fullURL = baseURL + router.urlString + apiKey + language
        
        let session = URLSessionNetwork(url: fullURL)
        return session.performRequest()
    }
    
//    func getRequest<T: Decodable>(_ router: Router) -> Future<T, NetworkError> {
//        return Future {[weak self] promise in
//            guard let self = self else { return }
//
//            let fullURL = self.baseURL + router.urlString + self.apiKey + self.language
//            self.session(fullURL, promise)
//        }
//    }
//
    
    // Convert From AnyPublisher to Future
    
//    private func session<T: Decodable>(_ url: String, _ result: @escaping (Result<T, NetworkError>) -> Void) {
//        let session = URLSessionNetwork(url: url)
//        session.performRequest().sink { completion in
//            switch completion {
//            case let .failure(error):
//                result(.failure(error))
//            case .finished:
//                break
//            }
//        } receiveValue: { (value: T) in
//            result(.success(value))
//        }
//        .store(in: &self.anyCancelable)
//    }
}
