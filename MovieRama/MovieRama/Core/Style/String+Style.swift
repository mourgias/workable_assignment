//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

extension String {
    
    func style(font: AppFonts,
               size: CGFloat,
               color: UIColor = .white,
               alignment: NSTextAlignment = .natural,
               lineBreakMode: NSLineBreakMode = .byWordWrapping,
               lineSpacing: CGFloat = 0,
               characterSpacing: CGFloat = 0) -> NSMutableAttributedString {
        
        let font = font.toFont(with: size)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.paragraphStyle.rawValue): paragraphStyle,
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.foregroundColor.rawValue): color,
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.font.rawValue): font]
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(attributes, range: NSRange(location: 0, length: self.count))
        
        return attributedString
    }
    
    static func textAttributes(font: AppFonts,
                               size: CGFloat,
                               color: UIColor = .white,
                               alignment: NSTextAlignment = .left,
                               lineBreakMode: NSLineBreakMode = .byWordWrapping,
                               lineSpacing: CGFloat = 0,
                               characterSpacing: CGFloat = 0) -> [NSAttributedString.Key : Any] {
        
        let font = font.toFont(with: size)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.paragraphStyle.rawValue): paragraphStyle,
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.foregroundColor.rawValue): color,
            NSAttributedString.Key(rawValue:  NSAttributedString.Key.font.rawValue): font]
        
        return attributes
    }
}
