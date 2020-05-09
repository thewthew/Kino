//
//  HomeScenePresenterTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeScenePresenterTests: XCTestCase {
    var viewControllerSpy: HomeSceneViewControllerSpy!
    var presenterUnderTesting: HomeScenePresenter!

    override func setUp() {
        super.setUp()
        viewControllerSpy = HomeSceneViewControllerSpy()
        presenterUnderTesting = HomeScenePresenter(viewController: viewControllerSpy)
    }

    func buildPopularSection() -> HomeSceneViewModel.Content {
        let sectionType = SectionType.popular
        let moviesCell = [HomeSceneViewModel.MovieCell(title: "Ad Asta"),
                          HomeSceneViewModel.MovieCell(title: "Extraction",
                          posterUrlString: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg"),
                          HomeSceneViewModel.MovieCell(title: "Birds of Prey")]
        let section = HomeSceneViewModel.Section(titleSection: sectionType, movies: moviesCell)
        return HomeSceneViewModel.Content(section: section)
    }

    func buildTrendingSection() -> HomeSceneViewModel.Content {
        let sectionType = SectionType.trending
        let moviesCell = [HomeSceneViewModel.MovieCell(title: "Diary of an E-Celeb"),
                          HomeSceneViewModel.MovieCell(title: "BlackList"),
                          HomeSceneViewModel.MovieCell(title: "An inconvenient Goof")]
        let section = HomeSceneViewModel.Section(titleSection: sectionType, movies: moviesCell)
        return HomeSceneViewModel.Content(section: section)
    }

    func buildCategoriesSection() -> HomeSceneViewModel.Content {
        let sectionType = SectionType.moviesCategory
        let moviesCell = [HomeSceneViewModel.MovieCell(title: "Action", genreID: 18),
                          HomeSceneViewModel.MovieCell(title: "Adventure", genreID: 22),
                          HomeSceneViewModel.MovieCell(title: "Comedy", genreID: 3),
                          HomeSceneViewModel.MovieCell(title: "Western", genreID: 6)]
        let section = HomeSceneViewModel.Section(titleSection: sectionType, movies: moviesCell)
        return HomeSceneViewModel.Content(section: section)
    }

    func builMovieSectionsViewModelStubbed() -> [HomeSceneViewModel.Content] {
        return [buildPopularSection(),
                buildTrendingSection(),
                buildCategoriesSection()]
    }

    // MARK: - test didFinishLoading
    func test_didFinishLoading() {
        // Given
        presenterUnderTesting.movieSectionViewModels = builMovieSectionsViewModelStubbed()

        // When
        presenterUnderTesting.didFinishLoading()
        let viewModel = viewControllerSpy.invokedViewModelUpdatedParameters?.viewModel
        let firstSection = viewModel?[0].section
        let secondSection = viewModel?[1].section
        let thirdSection = viewModel?[2].section

        // Then
        XCTAssert(viewControllerSpy.invokedViewModelUpdated)
        XCTAssertEqual(firstSection?.titleSection.rawValue, "Collection")
        XCTAssertEqual(secondSection?.titleSection.rawValue, "Popular")
        XCTAssertEqual(thirdSection?.titleSection.rawValue, "Trending")

        XCTAssertEqual(firstSection?.movies.first?.genreID, 18)
        XCTAssertEqual(secondSection?.movies[1].posterUrlString, "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg")
        XCTAssertEqual(thirdSection?.movies[2].title, "An inconvenient Goof")
    }

    // MARK: - test trendingMoviesModelUpdated
    func test_trendingMoviesModelUpdated() {
        // Given
        let moviesInfo = MoviesInfo.fromJSON(string: Movie.trendingMoviesJSON)!
        let movies = moviesInfo.movies

        // When
        presenterUnderTesting.trendingMoviesModelUpdated(movies: movies, title: .trending)

        // Then
        XCTAssertEqual(presenterUnderTesting.movieSectionViewModels.first?.section.movies.count, 2)
    }

    // MARK: - test popularMoviesModelUpdated
    func test_PopularMoviesModelUpdated() {
        // Given
        let moviesInfo = MoviesInfo.fromJSON(string: Movie.popularJSON)!
        let movies = moviesInfo.movies

        // When
        presenterUnderTesting.popularMoviesModelUpdated(movies: movies, title: .popular)

        // Then
        XCTAssertEqual(presenterUnderTesting.movieSectionViewModels.first?.section.movies.count, 3)
    }

    // MARK: - test modelCateoryMoviesUpdated
    func test_modelCategoryUpdated() {
        // Given
        let categoryInfo = MoviesCategory.fromJSON(string: Movie.movieListCategoryJSON)!

        // When
        presenterUnderTesting.modelCategoryUpdated(movieCategories: categoryInfo, title: .moviesCategory)

        // Then
        XCTAssertEqual(presenterUnderTesting.movieSectionViewModels.first?.section.movies.count, 10)
    }

}
