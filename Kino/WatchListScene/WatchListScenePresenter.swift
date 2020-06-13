//
//  WatchListScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol WatchListScenePresenterInput: class {
    func modelUpdated(movies: Movies)
}

final class WatchListScenePresenter {
    weak var viewController: WatchListSceneViewControllerInput?

    init(viewController: WatchListSceneViewControllerInput?) {
        self.viewController = viewController
    }

    private func getCells(from movies: Movies) -> [WatchListSceneViewModel.MovieCell] {
        return movies.map {
            WatchListSceneViewModel.MovieCell(movieId: $0.movieId,
                                              title: $0.title,
                                              releaseDate: $0.releaseDateFormatted ?? "",
                                              posterUrlString: $0.imageFullPathURL,
                                              description: $0.overview)
        }
    }
}

extension WatchListScenePresenter: WatchListScenePresenterInput {
    func modelUpdated(movies: Movies) {
        let viewModel = WatchListSceneViewModel.Section(movies: getCells(from: movies))
        viewController?.viewModelUpdated(viewModel)
    }
}
