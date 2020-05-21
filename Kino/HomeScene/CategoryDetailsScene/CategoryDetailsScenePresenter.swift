//
//  CategoryDetailsScenePresenter.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol CategoryDetailsScenePresenterInput: class {
    func modelUpdated(title: String)
    func moviesModelUpdated(movies: Movies)
}

final class CategoryDetailsScenePresenter {
    weak var viewController: CategoryDetailsSceneViewControllerInput?

    init(viewController: CategoryDetailsSceneViewControllerInput?) {
        self.viewController = viewController
    }

    private func getCells(from movies: Movies) -> [CategoryDetailsSceneViewModel.MovieCell] {
        return movies.map {
            CategoryDetailsSceneViewModel.MovieCell(title: $0.originalTitle,
                                                    releaseDate: $0.releaseDateFormatted ?? "",
                                                    posterUrlString: $0.imageFullPathURL,
                                                    description: $0.overview)
        }
    }
}

extension CategoryDetailsScenePresenter: CategoryDetailsScenePresenterInput {
    func modelUpdated(title: String) {
        let viewModel = CategoryDetailsSceneViewModel.Title(title: title)
        viewController?.viewModelUpdated(viewModel)
    }

    func moviesModelUpdated(movies: Movies) {
        let viewModel = CategoryDetailsSceneViewModel.Section(movies: getCells(from: movies))
        viewController?.moviesModelUpated(viewModel)
    }
}
