//
//  MovieApiServiceTest.swift
//  MovieApiServiceTest
//
//  Created by rakhmat cahyadi on 12/2/19.
//  Copyright © 2019 rakhmat cahyadi. All rights reserved.
//

import XCTest
@testable import Ghibli

class MovieApiServiceTest: XCTestCase {

    func testGetMovies() {
        let apiService = MovieApiService()
        let expectedMoviesLoaded = expectation(description: "expected movies loaded")
        let disposable = apiService.getMovieList()
            .subscribe(onSuccess:{ movies in
            XCTAssertGreaterThan(movies.count, 1)
            expectedMoviesLoaded.fulfill()
        })
        
        defer {
            disposable.dispose()
        }
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    fileprivate func assertMovies(movies: [Movie]) {
        movies.forEach { movie in
            assertMovie(movie: movie)
        }
    }
    
    fileprivate func assertMovie(movie: Movie) {
        XCTAssertNotNil(movie.id)
        XCTAssertNotNil(movie.description)
        XCTAssertNotNil(movie.director)
        XCTAssertNotNil(movie.releaseYear)
        XCTAssertNotNil(movie.title)
    }
}
