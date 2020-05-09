//
//  HomeScenePresenterSpy.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeScenePresenterSpy: HomeScenePresenterInput {
    var invokedTrendingMoviesModelUpdated = false
    var invokedTrendingMoviesModelUpdatedCount = 0
    var invokedTrendingMoviesModelUpdatedParameters: (movies: Movies, title: SectionType)?
    var invokedTrendingMoviesModelUpdatedParametersList = [(movies: Movies, title: SectionType)]()
    func trendingMoviesModelUpdated(movies: Movies, title: SectionType) {
        invokedTrendingMoviesModelUpdated = true
        invokedTrendingMoviesModelUpdatedCount += 1
        invokedTrendingMoviesModelUpdatedParameters = (movies, title)
        invokedTrendingMoviesModelUpdatedParametersList.append((movies, title))
    }
    var invokedPopularMoviesModelUpdated = false
    var invokedPopularMoviesModelUpdatedCount = 0
    var invokedPopularMoviesModelUpdatedParameters: (movies: Movies, title: SectionType)?
    var invokedPopularMoviesModelUpdatedParametersList = [(movies: Movies, title: SectionType)]()
    func popularMoviesModelUpdated(movies: Movies, title: SectionType) {
        invokedPopularMoviesModelUpdated = true
        invokedPopularMoviesModelUpdatedCount += 1
        invokedPopularMoviesModelUpdatedParameters = (movies, title)
        invokedPopularMoviesModelUpdatedParametersList.append((movies, title))
    }
    var invokedModelCategoryUpdated = false
    var invokedModelCategoryUpdatedCount = 0
    var invokedModelCategoryUpdatedParameters: (movieCategories: MoviesCategory, title: SectionType)?
    var invokedModelCategoryUpdatedParametersList = [(movieCategories: MoviesCategory, title: SectionType)]()
    func modelCategoryUpdated(movieCategories: MoviesCategory, title: SectionType) {
        invokedModelCategoryUpdated = true
        invokedModelCategoryUpdatedCount += 1
        invokedModelCategoryUpdatedParameters = (movieCategories, title)
        invokedModelCategoryUpdatedParametersList.append((movieCategories, title))
    }
    var invokedDidStartLoading = false
    var invokedDidStartLoadingCount = 0
    func didStartLoading() {
        invokedDidStartLoading = true
        invokedDidStartLoadingCount += 1
    }
    var invokedDidFinishLoading = false
    var invokedDidFinishLoadingCount = 0
    func didFinishLoading() {
        invokedDidFinishLoading = true
        invokedDidFinishLoadingCount += 1
    }
}
