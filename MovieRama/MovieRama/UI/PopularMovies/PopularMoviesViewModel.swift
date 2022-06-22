//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

protocol PopularMoviesViewModelProtocol {
    
    func fetchPopular()
}

class PopularMoviesViewModel: PopularMoviesViewModelProtocol {
    
    private var cancellable = Cancellable()
    
    var service: PopularMoviesServiceProtocol!
    
    init(service: PopularMoviesServiceProtocol = PopularMoviesService()) {
        self.service = service
    }
    
    deinit {
        print("♻️ PopularMoviesViewModel")
    }
    
    func fetchPopular() {
        
        service.fetchPopular(nextPage: 1).done { response in
            print(response.toPrintedJSON)
            
        } catchError: { error in
            print(error)
            
        }.store(in: &cancellable)
    }
}
