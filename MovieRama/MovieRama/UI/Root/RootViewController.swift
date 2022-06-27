//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Setup View
    
    private func setupView() {
        view.backgroundColor = .white
        
        self.setupTabBar()
    }
    
    // MARK: Setup Tab Bar
    
    func setupTabBar() {
        
        let tabBarViewController = TabBarViewController()
        
        let home = BaseNavigationController(rootViewController: PopularMoviesViewController())
        
        let favorites = BaseNavigationController(rootViewController: FavoritesViewController())
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "film"), tag: 0)
        favorites.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        
        tabBarViewController.viewControllers = [home, favorites]
        
        showRootViewController(rootVC: tabBarViewController)
    }
    
    // MARK: Setup Root View Controller
    
    func showRootViewController(rootVC: UIViewController) {
        rootVC.willMove(toParent: self)
        addChild(rootVC)
        rootVC.didMove(toParent: self)
        view.addSubview(rootVC.view)
        rootVC.view.bounds = view.bounds
    }
}
