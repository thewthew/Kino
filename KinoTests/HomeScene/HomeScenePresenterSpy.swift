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
    var invokedModelUpdatedParameters: (movies: Movies, Void)?
    var invokedModelUpdatedParametersList = [(movies: Movies, Void)]()
    func modelUpdated(movies: Movies) {
        invokedModelUpdated = true
        invokedModelUpdatedCount += 1
        invokedModelUpdatedParameters = (movies, ())
        invokedModelUpdatedParametersList.append((movies, ()))
    }
}
