//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct Pagination {
    
    let currentPage: Int
    let nextPage: Int
    let totalPages: Int
    
    var reachLastPage: Bool = false
}

extension Pagination {
    
   static func update(_ pagination: Pagination) -> Self {
        // check if reach the last page
        let reachLastPage = (pagination.totalPages == pagination.currentPage)
        
        // handle next page
        let next = reachLastPage ? pagination.totalPages : (pagination.currentPage + 1)
        
        return Pagination(currentPage: pagination.currentPage,
                          nextPage: next,
                          totalPages: pagination.totalPages,
                          reachLastPage: reachLastPage)
    }
}
