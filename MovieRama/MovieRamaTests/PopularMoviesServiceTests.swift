//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import XCTest
@testable import MovieRama

class PopularMoviesServiceTests: XCTestCase {
    
    var cancellable = Cancellable()
    
    var sutService: PopularMoviesService!
    
    override func setUp() {
        sutService = PopularMoviesService()
    }
    
    // Test PopularMoviesService
    func testServiceSuccessFetchMovies() {
        let expectation = XCTestExpectation(description: "fetch completed")
        
        // Given
        
        let nextPage = 1
        
        // When
        
        sutService.fetchPopular(nextPage: nextPage).done { (response: APIResponsePopularMovies) in
            
            let data = response.popularMovies
            print(data.count)
            
            // Then
            XCTAssertTrue(data.count > 0)
            expectation.fulfill()
            
        }.store(in: &cancellable)
        
        // Wait to execute async block
        
        wait(for: [expectation], timeout: 1)
    }

    // Test PopularMoviesService
    func testServiceFailedFetchMovies() {
        let expectation = XCTestExpectation(description: "fetch is not completed expect api error")
        
        // Given
        
        let nextPage = -1
        
        // When
        
        sutService.fetchPopular(nextPage: nextPage).done { (response: APIResponsePopularMovies) in
            
            let data = response.popularMovies
            print(data.count)
            
        } catchError: { error in
            
            print(error.localizedDescription)
            
            // Then
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
            
        }.store(in: &cancellable)
        
        // Wait to execute async block
        
        wait(for: [expectation], timeout: 1)
    }
    
    // Test PopularMoviesService
    func testServiceSuccessSearchMovies() {
        let expectation = XCTestExpectation(description: "fetch completed")
        
        // Given
        
        let nextPage = 1
        let searchText = "Iron"
        
        // When
        
        sutService.searchMovies(text: searchText, page: nextPage).done { (response: APIResponseSearch) in
            
            let data = response.results
            print(data.count)
            
            // Then
            XCTAssertTrue(data.count > 0)
            expectation.fulfill()
            
        }.store(in: &cancellable)
        
        // Wait to execute async block
        
        wait(for: [expectation], timeout: 1)
    }
    
}
