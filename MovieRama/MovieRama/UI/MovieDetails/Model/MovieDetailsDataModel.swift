//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct MovieDetailsDataModel {
    
    let id: String
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
    
    var isFavorite: Bool {
        DataContext.favorites.contains(where: { $0.id == id })
    }
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
