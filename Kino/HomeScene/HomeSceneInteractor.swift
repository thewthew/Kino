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

enum SectionType: String {
    case popular
    case trending
}

final class HomeSceneInteractor: KinoAPIInjected {
    var presenter: HomeScenePresenterInput?
    lazy var loadingQueue: KinoInteractorLoadingQueue? = {
        return KinoInteractorLoadingQueue(delegate: self)
    }()
    var movies: Movies!

    init(presenter: HomeScenePresenterInput?) {
        self.presenter = presenter
        self.movies = Movies()
    }
}

extension HomeSceneInteractor: HomeSceneInteractorInput {
    func loadContent() {
        loadingQueue?.add(.popularMovies)
        kinoAPI.getPopularMovies { (result: Result<MoviesInfo, APIServiceError>) in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.modelUpdated(movies: moviesInfo.movies, title: .popular)
                    self?.loadingQueue?.remove(task: .popularMovies)
                }
            case .failure(let error):
                print("\(#function) \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.loadingQueue?.remove(task: .popularMovies)
                }
            }
        }

        loadingQueue?.add(.trendingMovies)
        kinoAPI.getTrendingMovies { (result: Result<MoviesInfo, APIServiceError>) in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.modelUpdated(movies: moviesInfo.movies, title: .trending)
                    self?.loadingQueue?.remove(task: .trendingMovies)
                }
            case .failure(let error):
                print("\(#function) \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.loadingQueue?.remove(task: .trendingMovies)
                }
            }
        }
    }
}

extension HomeSceneInteractor: KinoInteractorLoadingQueueDelegate {
    func didStartLoading(queue: KinoInteractorLoadingQueue) {

    }

    func didFinishLoading(queue: KinoInteractorLoadingQueue) {
        presenter?.didFinishLoading()
    }
}
