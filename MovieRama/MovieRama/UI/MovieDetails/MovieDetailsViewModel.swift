//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
import Combine

class MovieDetailsViewModel {
    
    private var cancellable = Cancellable()
    private var service: MovieDetailsServiceProtocol

    var movieDetails: AnyPublisher<APIReponseMovieDetails, NetworkError> {
        return movieDetailsSubject.eraseToAnyPublisher()
    }
    
    private var movieDetailsSubject = PassthroughSubject<APIReponseMovieDetails, NetworkError>()
    
    init(service: MovieDetailsServiceProtocol = MovieDetailsService()) {
        self.service = service
    }

    func fetchDetails(id: String) {
        
        service.fetchMovie(id: id).done { [weak self] response in
            guard let self = self else { return }
            print(response)
            self.movieDetailsSubject.send(response)
            
        } catchError: { error in
            if let error = error as? NetworkError {
                self.movieDetailsSubject.send(completion: .failure(error))
            }
        }.store(in: &cancellable)
    }
}
