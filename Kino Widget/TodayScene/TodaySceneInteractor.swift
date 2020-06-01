//
//  TodaySceneInteractor.swift
//  Kino
//
//  Created by Matti on 23/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol TodaySceneInteractorInput: class {
    func loadContent()
    func openMovieDetails()
}

final class TodaySceneInteractor: KinoAPIInjected {
    var presenter: TodayScenePresenterInput?
    var movie: Movie?

    init(presenter: TodayScenePresenterInput?) {
        self.presenter = presenter
    }

    private func getSuggestedMovie() {
        kinoAPI.getSuggestedMovie { result in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    let randomID = Int.random(in: 0 ... moviesInfo.movies.count - 1)
                    let movieToShow = moviesInfo.movies[randomID]
                    self?.movie = movieToShow
                    self?.presenter?.modelUpdated(movieToShow)
                }
            case .failure(let error):
                print("\(#function) \(error)")
            }
        }
    }
}

extension TodaySceneInteractor: TodaySceneInteractorInput {
    func openMovieDetails() {
        guard let movie = movie,
        var url = URL(string: "com.kino://widget") else { return }
        url.appendPathComponent("\(movie.movieId)")
        url.appendPathComponent(movie.title)
        presenter?.displayMovieDetails(with: url)
    }

    func loadContent() {
        getSuggestedMovie()
    }
}
