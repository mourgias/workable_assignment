//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIResponseTVDetails: Codable {
    
    let adult: Bool
    let backdropPath: String?
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [APIResponseTVGenre]
    let homepage: String
    let movieId: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let name: String
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let status, tagline, type: String
    let voteAverage: Double
    let voteCount: Int
    let credits: APIReponseCredits
    
    // let productionCompanies: [Network]
    // let productionCountries: [ProductionCountry]
    // let seasons: [Season]
    // let spokenLanguages: [SpokenLanguage]
    // let nextEpisodeToAir: TEpisodeToAir
    // let networks: [Network]
    // let lastEpisodeToAir: TEpisodeToAir
    // let createdBy: [CreatedBy]
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage
        case movieId = "id"
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        
        case credits
        
        // case createdBy = "created_by"
        // case lastEpisodeToAir = "last_episode_to_air"
        // case nextEpisodeToAir = "next_episode_to_air"
        // case networks
        // case productionCompanies = "production_companies"
        // case productionCountries = "production_countries"
        // case seasons
        // case spokenLanguages = "spoken_languages"
    }
    
    var id: String {
        return String(movieId)
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
        if let runtime = episodeRunTime.first {
            return "\(runtime) minutes"
        }
        return "n/a"
    }
    
    var releaseDateFormatter: String {
        return firstAirDate.releaseDateFormatter
    }
    
    var voteAveragePercent: String {
        return ((voteAverage / 10) as NSNumber).toPercentage()
    }
}

struct APIResponseTVGenre: Codable {
    let id: Int
    let name: String
}
