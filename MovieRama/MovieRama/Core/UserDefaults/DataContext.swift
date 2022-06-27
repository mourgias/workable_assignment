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
    
    static var favorites: [Favorite] {
        
        get {
            if let data = UserDefaults.standard.value(forKey: ContextKey.favorites.key) as? Data {
                
                if let value = try? JSONDecoder().decode([Favorite].self, from: data) {
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
}

struct Favorite: Codable {
    
    let id: String
    let title: String
}
