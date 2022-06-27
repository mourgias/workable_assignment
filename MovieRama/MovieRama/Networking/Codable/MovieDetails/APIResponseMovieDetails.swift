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
    let movieId: Int
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
    let credits: APIReponseCredits
    
    // let spokenLanguages: [APIReponseSpokenLanguage]?
    // let productionCountries: [APIReponseProductionCountry]?
    // let productionCompanies: [APIReponseProductionCompany]?
    // let belongsToCollection: APIReponseBelongsToCollection?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        
        case budget, genres, homepage
        case movieId = "id"
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
        
        case credits
        
        // case belongsToCollection = "belongs_to_collection"
        // case spokenLanguages = "spoken_languages"
        // case productionCompanies = "production_companies"
        // case productionCountries = "production_countries"
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

struct APIReponseCredits: Codable {
    let cast, crew: [APIReponseCast]
    
    var director: APIReponseCast? {
        return crew.first(where: { $0.departmentType == .directing })
    }
}

struct APIReponseCast: Codable {
    let id: Int
    let adult: Bool
    let gender: Int?
    let knownForDepartment: String
    let name, originalName: String?
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
        case department
    }
    
    var knownDepartment: CrewDepartment {
        return CrewDepartment(rawValue: knownForDepartment) ?? .none
    }
    
    var departmentType: CrewDepartment? {
        return CrewDepartment(rawValue: department ?? "")
    }
    
    var profileImage: String {
        let url = baseImageURLw500 + (profilePath ?? "")
        return url
    }
}

enum CrewDepartment: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
    case creator
    case none
}
