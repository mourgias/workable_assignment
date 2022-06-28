//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

protocol PopularMoviesServiceProtocol {
    
    func fetchPopular(nextPage: Int) -> APIResponse<APIResponsePopularMovies>
    func searchMovies(text: String, page: Int) -> APIResponse<APIResponseSearch>
}

class PopularMoviesService: PopularMoviesServiceProtocol {
    
    func fetchPopular(nextPage: Int) -> APIResponse<APIResponsePopularMovies> {
        return HTTPClient.shared.getRequest(.popularMovies(page: nextPage))
    }
    
    func searchMovies(text: String, page: Int) -> APIResponse<APIResponseSearch> {
        return HTTPClient.shared.getRequest(.search(text: text, page: page))
    }
}
