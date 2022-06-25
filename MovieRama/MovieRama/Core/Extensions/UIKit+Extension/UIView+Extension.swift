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

public extension UICollectionViewCell {
    
    static var id: String {
        return String(describing: self)
    }
}

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    enum CornersMasked {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    func roundMaskedCorners(_ corners: [CornersMasked], radius: CGFloat) {
        var cornersMask: CACornerMask = []
        corners.forEach { corner in
            switch corner {
            case .topLeft:
                cornersMask.insert(.layerMinXMinYCorner)
            case .topRight:
                cornersMask.insert(.layerMaxXMinYCorner)
            case .bottomLeft:
                cornersMask.insert(.layerMinXMaxYCorner)
            case .bottomRight:
                cornersMask.insert(.layerMaxXMaxYCorner)
            }
        }
        layer.maskedCorners = cornersMask
        layer.cornerRadius = radius
    }
    
    func addCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
