//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

protocol PopularMoviesViewModelProtocol: ViewModelProtocol {
    
    func fetchPopular()
}

class PopularMoviesViewModel: PopularMoviesViewModelProtocol {
    
    var service: ServiceProtocol!
    
    init(service: ServiceProtocol = PopularMoviesService()) {
        self.service = service
    }
    
    deinit {
        print("♻️ PopularMoviesViewModel")
    }
    
    func fetchPopular() {
        
    }
}
