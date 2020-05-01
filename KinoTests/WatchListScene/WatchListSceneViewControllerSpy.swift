//
//  WatchListSceneViewControllerSpy.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class WatchListSceneViewControllerSpy: WatchListSceneViewControllerInput {
    var invokedViewModelUpdated = false
    var invokedViewModelUpdatedCount = 0
    var invokedViewModelUpdatedParameters: (viewModel: WatchListSceneViewModel.Content, Void)?
    var invokedViewModelUpdatedParametersList = [(viewModel: WatchListSceneViewModel.Content, Void)]()
    func viewModelUpdated(_ viewModel: WatchListSceneViewModel.Content) {
        invokedViewModelUpdated = true
        invokedViewModelUpdatedCount += 1
        invokedViewModelUpdatedParameters = (viewModel, ())
        invokedViewModelUpdatedParametersList.append((viewModel, ()))
    }
}
