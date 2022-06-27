//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
import Combine

class FavoritesViewModel {
    
    // MARK: ModieDataModel Source
    
    private var favoriteMovies: [MovieDataModel] = []
    
    // MARK: Reload data Publisher
    
    var reloadData: AnyPublisher<Void, Never> {
        return reloadDataSubject.eraseToAnyPublisher()
    }
    
    private var reloadDataSubject = PassthroughSubject<Void, Never>()
    
    init() { }
    
    func fetchFavorites() {
        favoriteMovies = DataContext.favorites
        reloadDataSubject.send()
    }
    
    func addToFavorites(id: String) {
        if let movie = favoriteMovies.first(where: { $0.id == id }) {
            DataContext.addFavorite(with: movie)
        }
    }
    
    func removeFromFavorites(at index: Int) {
        if favoriteMovies.indices.contains(index) {
            let favorite = favoriteMovies.remove(at: index)
            DataContext.removeFavorite(with: favorite.id)
        }
    }
}

// MARK: DataSource Methods

extension FavoritesViewModel {
    
    func dataModel(for index: Int) -> MovieDataModel? {
        guard favoriteMovies.indices.contains(index) else { return nil }
        return favoriteMovies[index]
    }
    
    func numberOfRows() -> Int {
        return favoriteMovies.count
    }
}
