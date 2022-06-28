//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

enum Router {
    
    case search(text: String, page: Int)
    
    case popularMovies(page: Int)
    
    // Movie Router
    
    case movieDetails(id: String)
    case movieReviews(id: String)
    case movieSimilar(id: String)
    
    // TV Router
    
    case tvDetails(id: String)
    case tvReviews(id: String)
    case tvSimilar(id: String)
    
    var urlString: String {
        switch self {
            
        case let .search(char, page):
            return "search/multi?query=\(char)&page=\(page)"
            
            // Movie Router
            
        case let .popularMovies(page):
            return "movie/popular?page=\(page)"
            
        case let .movieDetails(id):
            return "movie/\(id)?append_to_response=credits"
            
        case let .movieReviews(id):
            return "movie/\(id)/reviews?"
            
        case let .movieSimilar(id):
            return "movie/\(id)/similar?"
            
            // TV Router
            
        case let .tvDetails(id):
            return "tv/\(id)?append_to_response=credits"
            
        case let .tvReviews(id):
            return "tv/\(id)/reviews?"
            
        case let .tvSimilar(id):
            return "tv/\(id)/similar?"
        }
    }
    //https://api.themoviedb.org/3/tv/popular?api_key=30842f7c80f80bb3ad8a2fb98195544d&language=en-US&page=1
}
