//
//  MovieDetailsScenePresenter.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol MovieDetailsScenePresenterInput: class {
    func modelUpdated(_ movie: Movie, isFavorite: Bool)
    func switchFavoriteIcon(_ isOn: Bool)
}

final class MovieDetailsScenePresenter {
    weak var viewController: MovieDetailsSceneViewControllerInput?

    init(viewController: MovieDetailsSceneViewControllerInput?) {
        self.viewController = viewController
    }
}

extension MovieDetailsScenePresenter: MovieDetailsScenePresenterInput {
    func switchFavoriteIcon(_ isOn: Bool) {
        let iconName = isOn ? "star.fill" : "star"
        viewController?.updateFavoriteIcon(iconName)
    }

    func modelUpdated(_ movie: Movie, isFavorite: Bool) {
        let imageCell = MovieDetailsSceneViewModel.ImageCellViewModel(imageURL: movie.imageFullPathURL)
        let movieInfoTitle = movie.title + " " + "(\(movie.yearReleaseDate ?? "no release date"))"
        let basicCell = MovieDetailsSceneViewModel.BasicInfoViewModel(title: movieInfoTitle)
        let overviewCell = MovieDetailsSceneViewModel.OverviewViewModel(title: "Overview", description: movie.overview)

        let imageSection = MovieDetailsSceneViewModel.Section(modelType: .image, cells: [imageCell])
        let basicSection = MovieDetailsSceneViewModel.Section(modelType: .basicInfo, cells: [basicCell])
        let overviewSection = MovieDetailsSceneViewModel.Section(modelType: .overview, cells: [overviewCell])
        let sections = [imageSection, basicSection, overviewSection]

        let icon = isFavorite ? "star.fill" : "star"

        let viewModel = MovieDetailsSceneViewModel.Content(title: movie.title,
                                                           sections: sections,
                                                           iconName: icon)
        viewController?.viewModelUpdated(viewModel)
    }
}
