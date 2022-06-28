//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import XCTest
@testable import MovieRama

class MovieDetailsServiceTests: XCTestCase {
    
    var cancellable = Cancellable()
    
    var sutService: MovieDetailsService!
    
    override func setUp() {
        sutService = MovieDetailsService()
    }
    
    func testServiceSuccessFetchMovieDetails() {
        let expectation = XCTestExpectation(description: "fetch completed")
        
        // Given
        
        let movieId = "526896"
        
        // When
        
        sutService.fetchMovie(id: movieId).done { (details, reviews, similarMovies) in
            
            let detailsMovie = details.id
            
            // Then
            XCTAssertTrue(detailsMovie == movieId)
            expectation.fulfill()
            
        }.store(in: &cancellable)
        
        // Wait to execute async block
        
        wait(for: [expectation], timeout: 1)
    }

    func testServiceFailedFetchMovieDetails() {
        let expectation = XCTestExpectation(description: "fetch is not completed expect api error")

        // Given

        let movieId = "52689" // "526896"

        // When

        sutService.fetchMovie(id: movieId).done { (details, reviews, similarMovies) in

        } catchError: { error in

            print(error.localizedDescription)

            // Then

            XCTAssertNotNil(error)

            expectation.fulfill()

        }.store(in: &cancellable)

        // Wait to execute async block

        wait(for: [expectation], timeout: 1)
    }
    
    func testServiceSuccessFetchTVDetails() {
        let expectation = XCTestExpectation(description: "fetch completed")
        
        // Given
        
        let movieId = "60574"
        
        // When
        
        sutService.fetchTV(id: movieId).done { (details, reviews, similarMovies) in
            
            let detailsMovie = details.id
            
            // Then
            XCTAssertTrue(detailsMovie == movieId)
            expectation.fulfill()
            
        }.store(in: &cancellable)
        
        // Wait to execute async block
        
        wait(for: [expectation], timeout: 1)
    }

    func testServiceFailedFetchTVDetails() {
        let expectation = XCTestExpectation(description: "fetch is not completed expect api error")

        // Given

        let movieId = "6057" // "60574"

        // When

        sutService.fetchTV(id: movieId).done { (details, reviews, similarMovies) in

        } catchError: { error in

            print(error.localizedDescription)

            // Then

            XCTAssertNotNil(error)

            expectation.fulfill()

        }.store(in: &cancellable)

        // Wait to execute async block

        wait(for: [expectation], timeout: 1)
    }
}
