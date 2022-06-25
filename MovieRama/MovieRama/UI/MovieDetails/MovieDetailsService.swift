//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import Combine

protocol MovieDetailsServiceProtocol {
    
    func fetchMovie(id: String) -> APIResponse<APIReponseMovieDetails>
}

class MovieDetailsService: MovieDetailsServiceProtocol {
    
    func fetchMovie(id: String) -> APIResponse<APIReponseMovieDetails> {
        return HTTPClient.shared.getRequest(.movieDetails(id: id))
    }
}
