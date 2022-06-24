//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var navBarBackgroundView = UIView()
    
    private var titleLabel = UILabel()
    
    var navBarHeight: CGFloat {
        get {
            let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return 60.0 + (window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .appDarkGray
    }
    
    func addNavigationBar(title: String) {
        
        view.addSubview(navBarBackgroundView)
        navBarBackgroundView.addSubview(titleLabel)

        navBarBackgroundView.layout(
            .top(0),
            .leading(),
            .trailing(),
            .height(navBarHeight)
        )
        
        titleLabel.layout(
            .leading(25),
            .top(0, .to(view.safeAreaLayoutGuide, .top))
        )
        
        titleLabel.attributedText = title.style(font: .semiBold, size: 25)
        
        navBarBackgroundView.backgroundColor = .appLightGray
    }

}
