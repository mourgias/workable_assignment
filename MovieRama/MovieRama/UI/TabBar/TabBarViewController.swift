//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tabBar.tintColor = .appIndigoBlue
        tabBar.unselectedItemTintColor = .appGray
        
        tabBar.backgroundColor = .appLightGray
        tabBar.barTintColor = .appLightGray
        
        tabBar.layer.borderWidth = 0
        tabBar.layer.borderColor = UIColor.clear.cgColor
        
        tabBar.clipsToBounds = true
        
        view.backgroundColor = .white
        tabBar.isTranslucent = false
    }
}
