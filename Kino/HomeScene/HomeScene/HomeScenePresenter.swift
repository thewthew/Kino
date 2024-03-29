//
//  HomeScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol HomeScenePresenterInput: class {
    func trendingMoviesModelUpdated(movies: Movies, title: SectionType)
    func popularMoviesModelUpdated(movies: Movies, title: SectionType)
    func modelCategoryUpdated(movieCategories: MoviesCategory, title: SectionType)
    func didStartLoading()
    func didFinishLoading()
}

final class HomeScenePresenter {
    weak var viewController: HomeSceneViewControllerInput?
    var movieSectionViewModels = [HomeSceneViewModel.Content]()

    init(viewController: HomeSceneViewControllerInput?) {
        self.viewController = viewController
    }

    private func getCells(from movies: Movies) -> [HomeSceneViewModel.MovieCell] {
        return movies.map { HomeSceneViewModel.MovieCell(title: $0.title, posterUrlString: $0.imageFullPathURL) }
    }

    private func getSection(from movies: Movies, title: SectionType) -> HomeSceneViewModel.Section {
        return HomeSceneViewModel.Section(titleSection: title, movies: getCells(from: movies))
    }

    private func getCategoriesCells(from list: MoviesCategory) -> [HomeSceneViewModel.MovieCell] {
        return list.genres.map {
            HomeSceneViewModel.MovieCell(title: $0.name, genreID: $0.genreID)
        }
    }

    private func getCategory(from categories: MoviesCategory, title: SectionType) -> HomeSceneViewModel.Section {
        return HomeSceneViewModel.Section(titleSection: title, movies: getCategoriesCells(from: categories))
    }
}

extension HomeScenePresenter: HomeScenePresenterInput {
    func didStartLoading() {
        // TODO: start loading indicator
    }

    func didFinishLoading() {
        movieSectionViewModels.sort { $0.section.titleSection < $1.section.titleSection }
        viewController?.viewModelUpdated(movieSectionViewModels)
    }

    func trendingMoviesModelUpdated(movies: Movies, title: SectionType) {
        let viewModel = HomeSceneViewModel.Content(section: getSection(from: movies, title: title))
        movieSectionViewModels.append(viewModel)
    }

    func popularMoviesModelUpdated(movies: Movies, title: SectionType) {
        let viewModel = HomeSceneViewModel.Content(section: getSection(from: movies, title: title))
        movieSectionViewModels.append(viewModel)
    }

    func modelCategoryUpdated(movieCategories: MoviesCategory, title: SectionType) {
        let viewModel = HomeSceneViewModel.Content(section: getCategory(from: movieCategories, title: title))
        movieSectionViewModels.append(viewModel)
    }
}
