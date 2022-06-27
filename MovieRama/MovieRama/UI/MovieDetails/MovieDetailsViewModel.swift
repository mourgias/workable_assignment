//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
import Combine

class MovieDetailsViewModel {
    
    private var cancellable = Cancellable()
    
    // MARK: Service
    
    private var service: MovieDetailsServiceProtocol

    // MARK: Movie Publisher
    
    var movieDetails: AnyPublisher<MovieDetailsDataModel, NetworkError> {
        return movieDetailsSubject.eraseToAnyPublisher()
    }
    
    private var movieDetailsSubject = PassthroughSubject<MovieDetailsDataModel, NetworkError>()
    
    // MARK: Init
    
    init(service: MovieDetailsServiceProtocol = MovieDetailsService()) {
        self.service = service
    }

    func fetchDetails(id: String) {
        
        service.fetchMovie(id: id).done { [weak self] (details, reviews, similar) in
            guard let self = self else { return }
            //print(details, reviews, similar)
            
            self.buildDataModel(details, reviews, similar)
            
        } catchError: { error in
            if let error = error as? NetworkError {
                self.movieDetailsSubject.send(completion: .failure(error))
            }
        }.store(in: &cancellable)
    }
    
    // MARK: Build data model
    
    private func buildDataModel(_ details: APIReponseMovieDetails,
                                _ reviews: APIResponseReviews?,
                                _ similar:  APIReponseSimilarMovies?) {
        
        let reviews = buildReviews(reviews)
        
        let similar = buildSimilar(similar)
        
        let cast = details.credits.cast.compactMap { cast in
            MovieCharacter(name: cast.name ?? "", image: cast.profileImage)
        }
        
        let director = details.credits.director
        
        let dataModel = MovieDetailsDataModel(backDropImage: details.backDropImageUrl,
                                              title: details.title,
                                              summary: details.overview,
                                              genre: details.genre,
                                              posterImage: details.posterImageUrl,
                                              duration: details.duration,
                                              releaseDate: details.releaseDateFormatter,
                                              reviews: reviews,
                                              similar: similar,
                                              cast: cast,
                                              director: director)
        
        movieDetailsSubject.send(dataModel)
    }
    
    private func buildReviews(_ reviews: APIResponseReviews?) -> [ReviewsDataModel] {
        
        let reviews = reviews?.authors.prefix(2).compactMap { review in
            
            ReviewsDataModel(author: review.author,
                             content: review.content,
                             createdAt: review.createdAt,
                             image: review.authorDetails.avatarPath ?? "")
        }
        
        return reviews ?? []
    }
    
    private func buildSimilar(_ similar:  APIReponseSimilarMovies?) -> [SimilarDataModel] {
        
        let similar = similar?.results.compactMap { movie in
            
            SimilarDataModel(posterImage: movie.posterPath ?? "", title: movie.title)
        }
        
        return similar ?? []
    }

}
