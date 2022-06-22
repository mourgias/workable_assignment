//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesViewController: BaseViewController {
    
    // MARK: Properties
    
    var viewModel: PopularMoviesViewModelProtocol = PopularMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    // MARK: SetupView
    
    private func setupView() {
        
    }
    
    // MARK: Bind View Model
    
    private func bindViewModel() {
        viewModel.fetchPopular()
    }
}
