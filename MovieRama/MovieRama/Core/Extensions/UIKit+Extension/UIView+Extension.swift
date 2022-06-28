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

private var kIndicatorView = "indicatorView"

extension UITableView {
    
    private var bottomIndicatorView : UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &kIndicatorView) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &kIndicatorView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func prepareIndicator() {
        bottomIndicatorView = UIActivityIndicatorView(style: .medium)
        bottomIndicatorView?.color = .white
        
        bottomIndicatorView?.startAnimating()
        bottomIndicatorView?.frame = CGRect(x: 0, y: 0,
                                            width: bounds.width, height: 44)
        
        tableFooterView = bottomIndicatorView
        tableFooterView?.isHidden = false
    }
    
    func showBottomIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.prepareIndicator()
        }
    }
    
    func hideBottomIndicator() {
        
        if bottomIndicatorView?.isAnimating ?? false {
            bottomIndicatorView?.stopAnimating()
        }
        tableFooterView?.isHidden = true
        tableFooterView = nil
        bottomIndicatorView = nil
    }
    
    // MARK: Empty data source
    
    func setEmptyDataSourceMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.size.width, height: self.bounds.size.height))
        
        messageLabel.attributedText = message.style(font: .semiBold, size: 16, alignment: .center)
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func removeEmptyDataSourceMessage() {
        self.backgroundView = nil
    }
}
