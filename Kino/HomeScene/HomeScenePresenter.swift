//
//  HomeScenePresenter.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol HomeScenePresenterInput: class {
    func modelUpdated(movies: Movies, title: SectionType)
    func didStartLoading()
    func didFinishLoading()
}

final class HomeScenePresenter {
    weak var viewController: HomeSceneViewControllerInput?
    var movieSectionViewModels: [HomeSceneViewModel.Content]!

    init(viewController: HomeSceneViewControllerInput?) {
        self.viewController = viewController
        movieSectionViewModels = [HomeSceneViewModel.Content]()
    }

    private func getCells(from movies: Movies) -> [HomeSceneViewModel.MovieCell] {
        return movies.map { HomeSceneViewModel.MovieCell(title: $0.title, posterUrlString: $0.originalImageUrl) }
    }

    private func getSection(from movies: Movies, title: SectionType) -> HomeSceneViewModel.Section {
        return HomeSceneViewModel.Section(titleSection: title, movies: getCells(from: movies))
    }
}

extension HomeScenePresenter: HomeScenePresenterInput {
    func didStartLoading() {

    }

    func didFinishLoading() {
        let movieSortedSections = movieSectionViewModels.sorted {
            switch ($0.section.titleSection, $1.section.titleSection) {
            case (.popular, .trending):
                return true
            case (.trending, .popular):
                return false
            default:
                return true
            }
        }
        viewController?.viewModelUpdated(movieSortedSections)
    }

    func modelUpdated(movies: Movies, title: SectionType) {
        let viewModel = HomeSceneViewModel.Content(section: getSection(from: movies, title: title))
        movieSectionViewModels?.append(viewModel)
    }
}
