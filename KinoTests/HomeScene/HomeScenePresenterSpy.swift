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
    var invokedModelUpdated = false
    var invokedModelUpdatedCount = 0
    var invokedModelUpdatedParameters: (movies: Movies, title: SectionType)?
    var invokedModelUpdatedParametersList = [(movies: Movies, title: SectionType)]()
    func modelUpdated(movies: Movies, title: SectionType) {
        invokedModelUpdated = true
        invokedModelUpdatedCount += 1
        invokedModelUpdatedParameters = (movies, title)
        invokedModelUpdatedParametersList.append((movies, title))
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
}
