//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit
    
class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarHidden(true, animated: false)
    }
}
