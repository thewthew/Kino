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
}

final class MovieDetailsSceneInteractor {
    var presenter: MovieDetailsScenePresenterInput?
    var movie: Movie?

    init(presenter: MovieDetailsScenePresenterInput?) {
        self.presenter = presenter
    }
}

extension MovieDetailsSceneInteractor: MovieDetailsSceneInteractorInput {
    func loadContent() {
        guard let movie = movie else { return }
        presenter?.modelUpdated(movie)
    }
}
