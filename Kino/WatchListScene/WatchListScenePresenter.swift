//
//  WatchListScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol WatchListScenePresenterInput: class {
    func modelUpdated()
}

final class WatchListScenePresenter {
    weak var viewController: WatchListSceneViewControllerInput?

    init(viewController: WatchListSceneViewControllerInput?) {
        self.viewController = viewController
    }
}

extension WatchListScenePresenter: WatchListScenePresenterInput {
    func modelUpdated() {
        let viewModel = WatchListSceneViewModel.Content()
        viewController?.viewModelUpdated(viewModel)
    }
}
