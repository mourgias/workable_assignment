//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

public extension UIView {
    
    // https://stackoverflow.com/a/55372813/11739809
    func aspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
    
    @discardableResult
    func layout(_ anchor: LayoutAnchor...) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let superview = superview ?? self
        
        anchor.forEach { item in
            switch item {
                
            case let .top(value, alignto, priority):
                
                if case let .to(view, attributes) = alignto {
                    let top = alignTo(item: self, .top, item: view, attributes ?? .top, constant: value, priority: priority)
                    constraints.append(top)
                    return
                }
                
                let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: value)
                top.priority = priority
                
                top.isActive = true
                constraints.append(top)
                
            case let .bottom(value, alignto, priority):
                
                if case let .to(view, attributes) = alignto {
                    let bottom = alignTo(item: self, .bottom, item: view, attributes ?? .bottom, constant: -value, priority: priority)
                    constraints.append(bottom)
                    return
                }
                
                let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -value)
                bottom.priority = priority
                
                bottom.isActive = true
                constraints.append(bottom)
                
            case let .leading(value, alignto, priority):
                
                if case let .to(view, attributes) = alignto {
                    let leading = alignTo(item: self, .leading, item: view, attributes ?? .leading, constant: value, priority: priority)
                    constraints.append(leading)
                    return
                }
                
                let leading = leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: value)
                leading.priority = priority
                
                leading.isActive = true
                constraints.append(leading)
                
            case let .trailing(value, alignto, priority):
                
                if case let .to(view, attributes) = alignto {
                    let trailing = alignTo(item: self, .trailing, item: view, attributes ?? .trailing, constant: -value, priority: priority)
                    constraints.append(trailing)
                    return
                }
                
                let trailing = trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -value)
                trailing.priority = priority
                
                trailing.isActive = true
                constraints.append(trailing)
                
            case let .centerX(value, alignto):
                
                if case let .to(view, attributes) = alignto {
                    let centerX = alignTo(item: self, .centerX, item: view, attributes ?? .centerX, constant: -value)
                    constraints.append(centerX)
                    return
                }
                
                let centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: value)
                centerX.isActive = true
                constraints.append(centerX)
                
            case let .centerY(value, alignto):
                
                if case let .to(view, attributes) = alignto {
                    let centerY =  alignTo(item: self, .centerY, item: view, attributes ?? .centerY, constant: -value)
                    constraints.append(centerY)
                    return
                }
                
                let centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: value)
                centerY.isActive = true
                constraints.append(centerY)
                
            case .width(let value):
                let width = widthAnchor.constraint(equalToConstant: value)
                width.isActive = true
                constraints.append(width)
                
            case .height(let value):
                let height = heightAnchor.constraint(equalToConstant: value)
                height.isActive = true
                constraints.append(height)
                
            case .edges(let value):
                fixInView(superview, constant: value)
                
            case .center:
                centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 0).isActive = true
                centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0).isActive = true
            }
        }
        return constraints
    }
    
    enum AlignTo {
        case to(_ view: Any, _ attribute: NSLayoutConstraint.Attribute? = nil)
    }
    
    enum LayoutAnchor {
        case top(_ value: CGFloat = 0, _ to: AlignTo? = nil, _ priority: UILayoutPriority = .required)
        case leading(_ value: CGFloat = 0, _ to: AlignTo? = nil, _ priority: UILayoutPriority = .required)
        case trailing(_ value: CGFloat = 0, _ to: AlignTo? = nil, _ priority: UILayoutPriority = .required)
        case bottom(_ value: CGFloat = 0, _ to: AlignTo? = nil, _ priority: UILayoutPriority = .required)
        case centerY(_ value: CGFloat = 0, _ to: AlignTo? = nil)
        case centerX(_ value: CGFloat = 0, _ to: AlignTo? = nil)
        case height(CGFloat)
        case width(CGFloat)
        case edges(_ value: CGFloat = 0)
        case center(_ value: CGFloat = 0)
    }
    
    @discardableResult
    func alignTo(item item1: Any, _ attribute1: NSLayoutConstraint.Attribute, item item2: Any, _ attribute2: NSLayoutConstraint.Attribute, constant: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        (item2 as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = NSLayoutConstraint(item: item1, attribute: attribute1, relatedBy: .equal, toItem: item2, attribute: attribute2, multiplier: 1.0, constant: constant)
        
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }
    
    func fixInView(_ container: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: constant).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: -constant).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: constant).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: -constant).isActive = true
    }
}

public struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}
