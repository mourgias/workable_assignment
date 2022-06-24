//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

enum AppFonts: String {
    
    case semiBold = "Jura-SemiBold"
    case medium = "Jura-Medium"
    
    func toFont(with fontSize: CGFloat = 17) -> UIFont {
        let size: CGFloat = fontSize
        
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
