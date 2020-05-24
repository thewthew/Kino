//
//  TodayScenePresenter.swift
//  Kino
//
//  Created by Matti on 23/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol TodayScenePresenterInput: class {
    func modelUpdated(_ movie: Movie)
}

final class TodayScenePresenter {
    weak var viewController: TodaySceneViewControllerInput?

    init(viewController: TodaySceneViewControllerInput?) {
        self.viewController = viewController
    }
}

extension TodayScenePresenter: TodayScenePresenterInput {
    func modelUpdated(_ movie: Movie) {
        let viewModel = TodaySceneViewModel.Content(movieTitle: movie.title,
                                                    movieDescription: movie.overview,
                                                    moviePosterURL: movie.imageFullPathURL,
                                                    movieID: "\(movie.movieId)")
        viewController?.viewModelUpdated(viewModel)
    }
}
