//
//  HomeSceneViewControllerSpy.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeSceneViewControllerSpy: HomeSceneViewControllerInput {
    var invokedViewModelUpdated = false
    var invokedViewModelUpdatedCount = 0
    var invokedViewModelUpdatedParameters: (viewModel: HomeSceneViewModel.Content, Void)?
    var invokedViewModelUpdatedParametersList = [(viewModel: HomeSceneViewModel.Content, Void)]()
    func viewModelUpdated(_ viewModel: HomeSceneViewModel.Content) {
        invokedViewModelUpdated = true
        invokedViewModelUpdatedCount += 1
        invokedViewModelUpdatedParameters = (viewModel, ())
        invokedViewModelUpdatedParametersList.append((viewModel, ()))
    }
    var invokedViewModelTrendingUpdated = false
    var invokedViewModelTrendingUpdatedCount = 0
    var invokedViewModelTrendingUpdatedParameters: (viewModel: HomeSceneViewModel.Content, Void)?
    var invokedViewModelTrendingUpdatedParametersList = [(viewModel: HomeSceneViewModel.Content, Void)]()
    func viewModelTrendingUpdated(_ viewModel: HomeSceneViewModel.Content) {
        invokedViewModelTrendingUpdated = true
        invokedViewModelTrendingUpdatedCount += 1
        invokedViewModelTrendingUpdatedParameters = (viewModel, ())
        invokedViewModelTrendingUpdatedParametersList.append((viewModel, ()))
    }
}
