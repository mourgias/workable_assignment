//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

class DataContext {
    
    enum ContextKey {
        case favorites
        
        var key: String {
            return "k\(self)"
        }
    }
    
    static var favorites: [MovieDataModel] {
        
        get {
            if let data = UserDefaults.standard.value(forKey: ContextKey.favorites.key) as? Data {
                
                if let value = try? JSONDecoder().decode([MovieDataModel].self, from: data) {
                    return value
                }
            }
            return []
        }
        
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: ContextKey.favorites.key)
        }
    }
    
    static func removeFavorite(with id: String) {
        var favorites = favorites
        favorites.removeAll(where: { $0.id == id })
        self.favorites = favorites
    }
    
    static func addFavorite(with favorite: MovieDataModel) {
        var favorites = favorites
        favorites.append(favorite)
        self.favorites = favorites
    }
    
//    static func clearFavorites() {
//        var favorites = favorites
//        favorites.removeAll()
//        self.favorites = favorites
//    }
}
