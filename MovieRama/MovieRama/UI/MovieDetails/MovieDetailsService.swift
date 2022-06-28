//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

typealias Zip3<A, B, C> = Publishers.Zip3<APIResponse<A>, APIResponse<B>, APIResponse<C>>

protocol MovieDetailsServiceProtocol {
    
    func fetchMovie(id: String) -> Zip3<APIReponseMovieDetails,
                                        APIResponseReviews?,
                                        APIReponseSimilarMovies?>
    
    func fetchTV(id: String) -> Zip3<APIResponseTVDetails,
                                        APIResponseReviews?,
                                        APIReponseSimilarMovies?>

}

class MovieDetailsService: MovieDetailsServiceProtocol {
    
    private let client = HTTPClient.shared
    
    // MARK: Fetch Movie Details
    
    func fetchMovie(id: String) -> Zip3<APIReponseMovieDetails, APIResponseReviews?, APIReponseSimilarMovies?> {
        
        let movieDetails: APIResponse<APIReponseMovieDetails> = client.getRequest(.movieDetails(id: id))
        
        let movieReviews: APIResponse<APIResponseReviews?> = client.getRequest(.movieReviews(id: id))
            .proceedWith(with: nil)
        
        let movieSimilar: APIResponse<APIReponseSimilarMovies?> = client.getRequest(.movieSimilar(id: id))
            .proceedWith(with: nil)
        
        return Zip3(movieDetails, movieReviews, movieSimilar)
    }
    
    // MARK: Fetch TV Show Details
    
    func fetchTV(id: String) -> Zip3<APIResponseTVDetails, APIResponseReviews?, APIReponseSimilarMovies?> {
        
        let tvDetails: APIResponse<APIResponseTVDetails> = client.getRequest(.tvDetails(id: id))
        
        let tvReviews: APIResponse<APIResponseReviews?> = client.getRequest(.tvReviews(id: id))
            .proceedWith(with: nil)
        
        let tvSimilar: APIResponse<APIReponseSimilarMovies?> = client.getRequest(.tvSimilar(id: id))
            .proceedWith(with: nil)
        
        return Zip3(tvDetails, tvReviews, tvSimilar)
    }
}

extension Publisher {
    
    func proceedWith(with output: Self.Output) -> AnyPublisher<Self.Output, NetworkError> {
        
        // Catch and Print the Error
        self.catch { error -> AnyPublisher<Self.Output, NetworkError> in
            
            debugPrint(error)
            
            if let error = error as? NetworkError {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            return Fail(error: NetworkError.invalidRequest)
                .eraseToAnyPublisher()
        }
        .replaceError(with: output)
        .setFailureType(to: NetworkError.self)
        .eraseToAnyPublisher()
    }
}
