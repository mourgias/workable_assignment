//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIResponsePopularMovies: Codable {
    
    let page: Int
    let popularMovies: [APIResponsePopularMovie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case popularMovies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct APIResponsePopularMovie: Codable {
    
    let backdropPath: String?
    let movieId: Int
    let overview: String
    let releaseDate: String? // <-- 3.
    let title: String // <-- 2.
    let posterPath: String? // <-- 1.
    let video: Bool
    let voteAverage: Double // <-- 4.
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
    }
    
    var id: String {
        return String(movieId)
    }
    
    var voteAveragePercent: String {
        return ((voteAverage / 10) as NSNumber).toPercentage()
    }
    
    var releaseDateFormatted: String {
        return releaseDate?.releaseDateFormatter ?? ""
    }
    
    var posterImageUrl: String {
        let url = baseImageURLw500 + (posterPath ?? "")
        return url
    }
}
