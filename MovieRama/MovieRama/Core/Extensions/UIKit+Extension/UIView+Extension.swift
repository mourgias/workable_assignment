//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
}

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
