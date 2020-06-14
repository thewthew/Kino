//
//  WatchListSceneInteractor.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol WatchListSceneInteractorInput: class {
    func loadContent()
    var favoriteMovies: Movies? { get set }
}

final class WatchListSceneInteractor: DataManagerInjected {
    var presenter: WatchListScenePresenterInput?
    var favoriteMovies: Movies?
    init(presenter: WatchListScenePresenterInput?) {
        self.presenter = presenter
    }
}

extension WatchListSceneInteractor: WatchListSceneInteractorInput {

    func loadContent() {
        if let storedMovies = dataManager.fetchMovies() {
            favoriteMovies = storedMovies
            presenter?.modelUpdated(movies: storedMovies)
        }
    }
}
