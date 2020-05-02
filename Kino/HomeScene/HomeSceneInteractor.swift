//
//  HomeSceneInteractor.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol HomeSceneInteractorInput: class {
    func loadContent()
}

final class HomeSceneInteractor: KinoAPIInjected {
    var presenter: HomeScenePresenterInput?

    init(presenter: HomeScenePresenterInput?) {
        self.presenter = presenter
    }
}

extension HomeSceneInteractor: HomeSceneInteractorInput {
    func loadContent() {
        kinoAPI.getPopularMovies { (result: Result<MoviesInfo, APIServiceError>) in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.modelUpdated(movies: moviesInfo.movies)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
