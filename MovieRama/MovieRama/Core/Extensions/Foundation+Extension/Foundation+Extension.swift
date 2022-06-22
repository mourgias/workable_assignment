//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

extension NSNumber {
    
    func toPercentage() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumIntegerDigits = 1
        formatter.maximumIntegerDigits = 3
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self)!
    }
}

extension String {
    
    /// Format String To String : d MMM yyyy
    var releaseDateFormatter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        let date = formatter.date(from: self) ?? Date()
        formatter.dateFormat =  "d MMMM yyyy"
        return formatter.string(from: date)
    }
}
