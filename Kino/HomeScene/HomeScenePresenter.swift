//
//  HomeScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol HomeScenePresenterInput: class {
    func modelUpdated(movies: Movies)
}

final class HomeScenePresenter {
    weak var viewController: HomeSceneViewControllerInput?

    init(viewController: HomeSceneViewControllerInput?) {
        self.viewController = viewController
    }

    private func getCells(from movies: Movies) -> [HomeSceneViewModel.MovieCell] {
        return movies.map { (movie) -> HomeSceneViewModel.MovieCell in
            return HomeSceneViewModel.MovieCell(title: movie.title, posterUrlString: movie.originalImageUrl)
        }
    }

    private func getSection(from movies: Movies) -> [HomeSceneViewModel.Section] {
        let section = HomeSceneViewModel.Section(titleSection: "popular", movies: getCells(from: movies))
        return [section]
    }
}

extension HomeScenePresenter: HomeScenePresenterInput {
    func modelUpdated(movies: Movies) {
        let viewModel = HomeSceneViewModel.Content(section: getSection(from: movies))
        viewController?.viewModelUpdated(viewModel)
    }
}
