//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Easy access to BaseNavigationController could be nil
    ///
    var baseNavigationController: BaseNavigationController? {
        return (navigationController as? BaseNavigationController)
    }
}
