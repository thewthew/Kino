//
//  CategoryDetailsSceneInteractor.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol CategoryDetailsSceneInteractorInput: class {
    func loadContent()
    var genre: Genre! { get set }
    var moviesList: Movies { get }
}

final class CategoryDetailsSceneInteractor: KinoAPIInjected {
    var presenter: CategoryDetailsScenePresenterInput?
    var genre: Genre!
    var moviesList: Movies

    init(presenter: CategoryDetailsScenePresenterInput?) {
        self.presenter = presenter
        self.moviesList = Movies()
    }
}

extension CategoryDetailsSceneInteractor: CategoryDetailsSceneInteractorInput {
    func loadContent() {
        let title = genre.name + " " + String(genre.genreID)
        presenter?.modelUpdated(title: title)

        let genreID = String(genre.genreID) + "-" + genre.name
        kinoAPI.getMoviesCollection(genreID) { [weak self] (result) in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async {
                    self?.presenter?.moviesModelUpdated(movies: moviesInfo.movies)
                    self?.moviesList = moviesInfo.movies
                }
            case .failure(let error):
                print(#function + error.localizedDescription)
            }
        }
    }
}
