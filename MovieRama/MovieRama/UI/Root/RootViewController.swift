//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var tabBarViewController: UIViewController?
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Setup View
    
    private func setupView() {
        view.backgroundColor = .white
        
        self.setupTabBar()
        self.showRootViewController()
    }
    
    // MARK: Setup Tab Bar
    
    func setupTabBar() {
        
    }
    
    // MARK: Setup Root View Controller
    
    func showRootViewController() {
        
    }
}
