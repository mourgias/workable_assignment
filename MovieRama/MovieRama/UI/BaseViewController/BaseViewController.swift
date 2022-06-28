//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    enum ButtonType {
        case back
    }
    
    private var navBarBackgroundView = UIView()
    
    private var titleLabel = UILabel()
    
    private(set) var searchView = SearchView()
    
    private(set) var leftNavBarButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    var navBarHeight: CGFloat {
        get {
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return 60.0 + (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + searchFieldHeight
        }
    }
    
    private var searchFieldHeight: CGFloat {
        return isSearchBarActive ? 30 : 0 // 25
    }
    
    private var isSearchBarActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .appDarkGray
    }
    
    func addNavigationBar(title: String? = nil, leftButton: ButtonType? = nil, hideNavBackground: Bool = false, hasSearch: Bool = false) {
        
        isSearchBarActive = hasSearch
        
        if !hideNavBackground {
            view.addSubview(navBarBackgroundView)
            navBarBackgroundView.layout(
                .top(0),
                .leading(),
                .trailing(),
                .height(navBarHeight)
            )
            
            if hasSearch {
                
                navBarBackgroundView.addSubview(searchView)
                
                searchView.layout(
                    .leading(0),
                    .trailing(0),
                    .bottom(7)
                )
            }
        }
        
        if let title = title {
            navBarBackgroundView.addSubview(titleLabel)
            
            titleLabel.layout(
                .leading(25),
                .top(0, .to(view.safeAreaLayoutGuide, .top))
            )
            
            titleLabel.attributedText = title.style(font: .semiBold, size: 25)
        }
        
        navBarBackgroundView.backgroundColor = .appLightGray
        
        switch leftButton {
            
        case .back:
            setupBackButton()
            
        case .none:
            break
        }
    }
}

extension BaseViewController {
    
    func setupBackButton() {
        view.addSubview(leftNavBarButton)
        
        leftNavBarButton.layout(
            .leading(25),
            .top(0, .to(view.safeAreaLayoutGuide, .top))
        )
        
        leftNavBarButton.setImage(UIImage(named: "back_icon"), for: .normal)
        leftNavBarButton.tintColor = .white
    }
}
