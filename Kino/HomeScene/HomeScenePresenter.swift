//
//  HomeScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol HomeScenePresenterInput: class {
    func modelUpdated()
}

final class HomeScenePresenter {
    weak var viewController: HomeSceneViewControllerInput?

    init(viewController: HomeSceneViewControllerInput?) {
        self.viewController = viewController
    }
}

extension HomeScenePresenter: HomeScenePresenterInput {
    func modelUpdated() {
        let viewModel = HomeSceneViewModel.Content()
        viewController?.viewModelUpdated(viewModel)
    }
}
