//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

public enum CacheMethod {
    
    case none
    case memory
    
    // MARK: Retrieve Image with key
    
    public func getImage(for key: String) -> UIImage? {
        switch self {
            
        case .none:
            return nil
            
        case .memory:
            return ImageCache.getImage(for: key)
        }
    }
    
    // MARK: Store Image with key
    
    public func saveImage(_ image: UIImage, for key: String) {
        switch self {
            
        case .none:
            break
            
        case .memory:
            ImageCache.set(image, for: key)
        }
    }
}
