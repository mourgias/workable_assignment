//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

typealias Zip3<A, B, C> = Publishers.Zip3<APIResponse<A>, APIResponse<B>, APIResponse<C>>
typealias CombineLatest3<A, B, C> = Publishers.CombineLatest3<APIResponse<A>, APIResponse<B>, APIResponse<C>>

protocol MovieDetailsServiceProtocol {
    
    func fetchMovie(id: String) -> Zip3<APIReponseMovieDetails,
                                        APIResponseReviews?,
                                        APIReponseSimilarMovies?>
    
    //func fetch(id: String) -> AnyPublisher<(APIReponseMovieDetails, APIReponseSimilarMovies?), NetworkError>
}

class MovieDetailsService: MovieDetailsServiceProtocol {
    
    var cancel = Cancellable()
    
    private let client = HTTPClient.shared
    
    func fetchMovie(id: String) -> Zip3<APIReponseMovieDetails, APIResponseReviews?, APIReponseSimilarMovies?> {
        
        let movieDetails: APIResponse<APIReponseMovieDetails> = client.getRequest(.movieDetails(id: id))
        
        let movieReviews = fetchReviews(id: id)
        
        let movieSimilar = fetchSimilar(id: id)
        
        return Zip3(movieDetails, movieReviews, movieSimilar)
    }
    
    func fetchReviews(id: String) -> APIResponse<APIResponseReviews?> {
        
        return client.getRequest(.movieReviews(id: id))
            .catch { error -> APIResponse<APIResponseReviews?> in
                return Just(nil)
                    .setFailureType(to: NetworkError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
//            .replaceError(with: nil)
//            .setFailureType(to: NetworkError.self)
//            .eraseToAnyPublisher()
    }
    
    func fetchSimilar(id: String) -> APIResponse<APIReponseSimilarMovies?> {
        
        return client.getRequest(.movieSimilar(id: id))
            .replaceError(with: nil)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
//
//    func fetch(id: String) -> AnyPublisher<(APIReponseMovieDetails, APIReponseSimilarMovies?), NetworkError> {
//
//        let movieDetails: APIResponse<APIReponseMovieDetails> = client.getRequest(.movieDetails(id: id))
//        let movieCredits: APIResponse<APIResponseReviews> = client.getRequest(.movieReviews(id: id))
//        let movieSimilar: APIResponse<APIReponseSimilarMovies> = client.getRequest(.movieSimilar(id: id))
//
//        let datum = fetchMovies(id: id).flatMap { details in
//
//            self.fetchSimilar(id: id)
//
//        }
//        .eraseToAnyPublisher()
//
//        return fetchMovies(id: id).flatMap { details in
//
////            self.fetchSimilar(id: id)
////                .replaceError(with: nil)
//
//            Just(details).setFailureType(to: NetworkError.self)
//                .zip(self.fetchSimilar(id: id).replaceError(with: nil).setFailureType(to: NetworkError.self))
//
//        }.eraseToAnyPublisher()
//    }
//
//    func fetchMovies(id: String) -> AnyPublisher<APIReponseMovieDetails, NetworkError> {
//
//        return client.getRequest(.movieDetails(id: id))
//    }
//
//    func fetchSimilar(id: String) -> AnyPublisher<APIReponseSimilarMovies?, NetworkError> {
//
//        return client.getRequest(.movieSimilar(id: id))
//    }
}
