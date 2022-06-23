//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

protocol PopularMoviesServiceProtocol {
    
    func fetchPopular(nextPage: Int) -> APIResponse<APIResponsePopularMovies>
}

class PopularMoviesService: PopularMoviesServiceProtocol {
    
    func fetchPopular(nextPage: Int) -> APIResponse<APIResponsePopularMovies> {
        return HTTPClient.shared.getRequest(.popularMovies(page: nextPage))
    }
}
