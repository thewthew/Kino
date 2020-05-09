//
//  HomeSceneInteractorTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeSceneInteractorTests: KinoTests {
    var presenterSpy: HomeScenePresenterSpyExpected!
    var interactorUnderTesting: HomeSceneInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = HomeScenePresenterSpyExpected()
        interactorUnderTesting = HomeSceneInteractor(presenter: presenterSpy)
    }

    // MARK: - test loadContent
    func test_loadContent_GivenAllWSSucceed() {
        // Given
        presenterSpy.categoryExpectation = expectation(description: #function)
        presenterSpy.trendingExpectation = expectation(description: #function)
        presenterSpy.popularExpectation = expectation(description: #function)

        // When
        stubWebService(for: KinoAPI.Endpoint.movieList.rawValue, with: Movie.movieListCategoryJSON)
        stubWebService(for: KinoAPI.Endpoint.discoverMovies.rawValue, with: Movie.trendingMoviesJSON)
        stubWebService(for: KinoAPI.Endpoint.discoverMovies.rawValue, with: Movie.popularJSON)
        interactorUnderTesting.loadContent()

        waitForExpectations(timeout: 2) { [weak self] (_) in
            XCTAssertEqual(self?.presenterSpy.invokedModelCategoryUpdated, true)
            XCTAssertEqual(self?.presenterSpy.invokedTrendingMoviesModelUpdated, true)
            XCTAssertEqual(self?.presenterSpy.invokedPopularMoviesModelUpdated, true)

        }
    }
    func test_loadContent_GivenGetMoviesCategorySucceed() {
        // Given
        presenterSpy.categoryExpectation = expectation(description: #function)

        // When
        stubWebService(for: KinoAPI.Endpoint.movieList.rawValue, with: Movie.movieListCategoryJSON)
        interactorUnderTesting.loadContent()

        // Then
        waitForExpectations(timeout: 2) { [weak self] (_) in
            let viewModel = self?.presenterSpy.invokedModelCategoryUpdatedParameters

            XCTAssertEqual(self?.presenterSpy.invokedModelCategoryUpdated, true)
            XCTAssertEqual(viewModel?.movieCategories.genres.count, 10)
            XCTAssertEqual(viewModel?.movieCategories.genres.first?.name, "Actions")
        }
    }

    func test_loadContent_GivenGetTrendingMoviesSucceed() {
        // Given
        presenterSpy.trendingExpectation = expectation(description: #function)

        // When
        stubWebService(for: KinoAPI.Endpoint.discoverMovies.rawValue, with: Movie.trendingMoviesJSON)
        interactorUnderTesting.loadContent()

        // Then
        waitForExpectations(timeout: 2) { [weak self] (_) in
            let viewModel = self?.presenterSpy.invokedTrendingMoviesModelUpdatedParameters

            XCTAssertEqual(self?.presenterSpy.invokedTrendingMoviesModelUpdated, true)
            XCTAssertEqual(viewModel?.movies.count, 2)
            XCTAssertEqual(viewModel?.title.rawValue, "Trending")
        }
    }

    func test_loadContent_GivenGetPopularMoviesSucceed() {
        // Given
        presenterSpy.popularExpectation = expectation(description: #function)

        // When
        stubWebService(for: KinoAPI.Endpoint.discoverMovies.rawValue, with: Movie.popularJSON)
        interactorUnderTesting.loadContent()

        // Then
        waitForExpectations(timeout: 2) { [weak self] (_) in
            let viewModel = self?.presenterSpy.invokedPopularMoviesModelUpdatedParameters

            XCTAssertEqual(self?.presenterSpy.invokedPopularMoviesModelUpdated, true)
            XCTAssertEqual(viewModel?.movies.count, 3)
            XCTAssertEqual(viewModel?.title.rawValue, "Popular")
        }
    }

    class HomeScenePresenterSpyExpected: HomeScenePresenterSpy {
        var categoryExpectation: XCTestExpectation?
        var trendingExpectation: XCTestExpectation?
        var popularExpectation: XCTestExpectation?

        override func trendingMoviesModelUpdated(movies: Movies, title: SectionType) {
            super.trendingMoviesModelUpdated(movies: movies, title: title)
            trendingExpectation?.fulfill()
        }

        override func popularMoviesModelUpdated(movies: Movies, title: SectionType) {
            super.popularMoviesModelUpdated(movies: movies, title: title)
            popularExpectation?.fulfill()
        }

        override func modelCategoryUpdated(movieCategories: MoviesCategory, title: SectionType) {
            super.modelCategoryUpdated(movieCategories: movieCategories, title: title)
            categoryExpectation?.fulfill()
        }
    }
}
