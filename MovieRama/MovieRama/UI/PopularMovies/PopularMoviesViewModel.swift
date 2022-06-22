//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

protocol PopularMoviesViewModelProtocol {
    
    func fetchPopular()
}

class PopularMoviesViewModel: PopularMoviesViewModelProtocol {
    
    var service: PopularMoviesServiceProtocol!
    
    init(service: PopularMoviesServiceProtocol = PopularMoviesService()) {
        self.service = service
    }
    
    deinit {
        print("♻️ PopularMoviesViewModel")
    }
    
    func fetchPopular() {
        
    }
}
