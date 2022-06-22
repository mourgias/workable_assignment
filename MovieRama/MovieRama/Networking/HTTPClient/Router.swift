//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

enum Router {
    
    //case search(String)
    
    case popularMovies(page: Int)
    
    case movieDetails(id: String)
    case movieReviews(id: String)
    case movieSimilar(id: String)
    
    var urlString: String {
        switch self {
            
        case let .popularMovies(page):
            return "movie/popular?page=\(page)"
            
        case let .movieDetails(id):
            return "movie/\(id)?append_to_response=credits"
            
        case let .movieReviews(id):
            return "movie/\(id)/reviews?"
            
        case let .movieSimilar(id):
            return "movie/\(id)/similar?"
        }
    }
    //https://api.themoviedb.org/3/tv/popular?api_key=30842f7c80f80bb3ad8a2fb98195544d&language=en-US&page=1
}
