//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    // MARK: UIRefreshControl
    
    private let customRefreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .white
        return rc
    }()
    
    var showRefreshControl: Bool = false {
        didSet {
            if showRefreshControl {
                setupRefreshControl()
            } else {
                backgroundView = nil
            }
        }
    }
    
    override var contentInset: UIEdgeInsets {
        didSet {
            // Change origin y cause of tableView content inset
            customRefreshControl.bounds.origin.y = -contentInset.top
            verticalScrollIndicatorInsets.top = contentInset.top
        }
    }
    
    // MARK: Set Refresh control on table view backgroundView
    
    private func setupRefreshControl() {
        backgroundView = customRefreshControl
    }
    
    // MARK: Start refresh control animation
    
    func beginRefreshingControl() {
        customRefreshControl.beginRefreshing()
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    // MARK: Stop refresh control animation
    
    func endRefreshingControl() {
        if self.customRefreshControl.isRefreshing {
            self.customRefreshControl.endRefreshing()
            
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        }
    }
    
    func addRefreshTarget(_ target: Any?, action: Selector) {
        customRefreshControl.addTarget(target, action: action, for: .valueChanged)
    }
}
