//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct MovieDetailsDataModel {
    
    let backDropImage: String
    let title: String
    let summary: String?
    let genre: String
    let posterImage: String
    let duration: String
    let releaseDate: String
    
    let reviews: [ReviewsDataModel]
    let similar: [SimilarDataModel]
    let cast: [MovieCharacter]
    let director: APIReponseCast?
}

struct ReviewsDataModel {
    
    let author: String
    let content: String
    let createdAt: String
    let image: String?
}

struct SimilarDataModel {
    
    let posterImage: String?
    let title: String
}

struct MovieCharacter {
    let name: String
    let image: String?
}
