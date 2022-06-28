//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIResponseSearch: Codable {
    let page: Int
    private let searchResults: [APIResponseSearchResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case searchResults = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    var results: [APIResponseSearchResult] {
        return searchResults.filter { $0.mediaType == .tv || $0.mediaType == .movie }
    }
}

struct APIResponseSearchResult: Codable {
    
    let movieId: Int                   // Both
    let posterPath: String?            // Both
    let overview: String?              // Both
    let genreIDS: [Int]?               // Both
    let backdropPath: String?          // Both
    let media: String?                 // Both
    let originalLanguage: String?      // Both
    let popularity: Double?            // Both
    let voteCount: Int?                // Both
    
    let adult: Bool?
    let releaseDate: String?
    let firstAirDate: String?
    
    let name: String?
    let movieTitle: String?
    let originalName: String?
    let originalTitle: String?

    let video: Bool?
    let voteAverage: Double?
    
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case movieId = "id"
        case media = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case movieTitle = "title"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
    
    var mediaType: MediaType {
        return MediaType(rawValue: media ?? "") ?? .none
    }
    
    var voteAveragePercent: String {
        return (((voteAverage ?? 0) / 10) as NSNumber).toPercentage()
    }
    
    var releaseDateFormatted: String {
        switch mediaType {
        case .movie:
            return releaseDate?.releaseDateFormatter ?? ""
        case .tv:
            return firstAirDate?.releaseDateFormatter ?? ""
        default:
            return "n/a"
        }
    }
    
    var posterImageUrl: String {
        let url = baseImageURLw500 + (posterPath ?? "")
        return url
    }
    
    var title: String {
        if let name = name {
            return name
        } else if let movieTitle = movieTitle {
            return movieTitle
        }
        return "n/a"
    }
    
    var id: String {
        return String(movieId)
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case none
}
