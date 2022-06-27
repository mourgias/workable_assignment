//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIReponseSimilarMovies: Codable {
    let page: Int
    let results: [APIResponseSimilarMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct APIResponseSimilarMovie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview, releaseDate: String
    let posterPath: String?
    let popularity: Double
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterImageUrl: String {
        let url = baseImageURLw500 + (posterPath ?? "")
        return url
    }
}
