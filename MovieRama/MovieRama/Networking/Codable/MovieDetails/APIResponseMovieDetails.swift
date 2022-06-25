//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIReponseMovieDetails: Codable {
    
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [APIReponseGenre]
    let homepage: String?
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let status: String
    let tagline: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    // let spokenLanguages: [APIReponseSpokenLanguage]?
    // let productionCountries: [APIReponseProductionCountry]?
    // let productionCompanies: [APIReponseProductionCompany]?
    // let belongsToCollection: APIReponseBelongsToCollection?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        
        case releaseDate = "release_date"
        case revenue, runtime
        
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
        // case belongsToCollection = "belongs_to_collection"
        // case spokenLanguages = "spoken_languages"
        // case productionCompanies = "production_companies"
        // case productionCountries = "production_countries"
    }
    
    var posterImageUrl: String {
        let url = baseImageURLw500 + (posterPath ?? "")
        return url
    }
    
    var backDropImageUrl: String {
        let url = baseImageURLw500 + (backdropPath ?? "")
        return url
    }
    
    var genre: String {
        return genres.first?.name ?? "n/a"
    }
    
    var duration: String {
        if let runtime = runtime {
            return "\(runtime) minutes"
        }
        return "n/a"
    }
    
    var releaseDateFormatter: String {
        return releaseDate.releaseDateFormatter
    }
}

struct APIReponseGenre: Codable {
    let id: Int
    let name: String
}
