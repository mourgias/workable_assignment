//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct MovieDataModel: Codable {
    
    let id: String
    let title: String
    let voteAveragePercent: String
    var voteAverageValue: Double
    let releaseDateFormatted: String
    let posterImageUrl: String
    
    var mediaType: MediaType? = nil
    
    var isFavorite: Bool {
        DataContext.favorites.contains(where: { $0.id == id })
    }
}
