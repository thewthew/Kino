//
//  MovieDetailsSceneInteractor.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol MovieDetailsSceneInteractorInput: class {
    func loadContent()
    var movie: Movie? { get set }
    var idMovie: String? { get set }
    func didTapFavoriteButton()
}

final class MovieDetailsSceneInteractor: KinoAPIInjected, DataManagerInjected {
    var presenter: MovieDetailsScenePresenterInput?
    var movie: Movie?
    var idMovie: String?

    init(presenter: MovieDetailsScenePresenterInput?) {
        self.presenter = presenter
    }

    private func fetchMovieDetails(_ idMovie: String) {
        kinoAPI.getMovie(idMovie) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    let isFavorite = self.dataManager.isFavorite(movie.movieId)
                    self.presenter?.modelUpdated(movie, isFavorite: isFavorite)
                }
            case .failure(let error):
                print(#function + error.localizedDescription)
            }
        }
    }
}

extension MovieDetailsSceneInteractor: MovieDetailsSceneInteractorInput {
    func didTapFavoriteButton() {
        guard let movie = movie else { return }
        if dataManager.isFavorite(movie.movieId) {
            presenter?.switchFavoriteIcon(false)
            dataManager.removeMovie(movie.movieId)
        } else {
            presenter?.switchFavoriteIcon(true)
            dataManager.storeMovie(movie)
        }
    }

    func loadContent() {
        if let movie = movie {
            let isFavorite = dataManager.isFavorite(movie.movieId)
            presenter?.modelUpdated(movie, isFavorite: isFavorite)
        } else if let idMovie = idMovie {
            fetchMovieDetails(idMovie)
        }
    }
}
