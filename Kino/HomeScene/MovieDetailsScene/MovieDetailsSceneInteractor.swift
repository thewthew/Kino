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
}

final class MovieDetailsSceneInteractor: KinoAPIInjected {
    var presenter: MovieDetailsScenePresenterInput?
    var movie: Movie?
    var idMovie: String?

    init(presenter: MovieDetailsScenePresenterInput?) {
        self.presenter = presenter
    }

    private func fetchMovieDetails(_ idMovie: String) {
        kinoAPI.getMovie(idMovie) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.presenter?.modelUpdated(movie)
                }
            case .failure(let error):
                print(#function + error.localizedDescription)
            }
        }
    }
}

extension MovieDetailsSceneInteractor: MovieDetailsSceneInteractorInput {

    func loadContent() {
        if let movie = movie {
            presenter?.modelUpdated(movie)
        } else if let idMovie = idMovie {
            fetchMovieDetails(idMovie)
        }
    }
}
