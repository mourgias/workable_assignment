//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import UIKit

open class ImageCache {
    
    public static var cache = NSCache<NSString, UIImage>()
    
    // MARK: Set Image
    
    public static func set(_ value: UIImage?, for key: String) {
        
        guard let value = value else {
            cache.removeObject(forKey: NSString(string: key))
            return
        }
        
        cache.setObject(value, forKey: NSString(string: key))
    }
    
    // MARK: Retrieve Image
    
    public static func getImage(for key: String) -> UIImage? {
        guard key != "" else { return nil }
        return cache.object(forKey: NSString(string: key))
    }
    
    public static func clearCache() {
        cache.removeAllObjects()
    }
}
