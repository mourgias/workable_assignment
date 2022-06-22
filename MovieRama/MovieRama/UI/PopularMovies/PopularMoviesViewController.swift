//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation
import UIKit

class PopularMoviesViewController: UIViewController {
    
    var viewModel: PopularMoviesViewModelProtocol = PopularMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        
    }
    
    func bindViewModel() {
        viewModel.fetchPopular()
    }
}
