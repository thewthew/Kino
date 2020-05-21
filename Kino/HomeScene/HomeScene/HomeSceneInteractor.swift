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
    var genres: Genres { get }
    var moviesList: [SectionType: Movies] { get }
}

enum SectionType: String, CaseIterable, Comparable {
    case popular = "Popular"
    case moviesCategory = "Collection"
    case trending = "Trending"

    static func < (lhs: SectionType, rhs: SectionType) -> Bool {
        return lhs.sortOrder < rhs.sortOrder
    }

    private var sortOrder: Int {
        switch self {
        case .moviesCategory:
            return 0
        case .popular:
            return 1
        case .trending:
            return 2
        }
    }
}

final class HomeSceneInteractor: KinoAPIInjected {
    var presenter: HomeScenePresenterInput?
    lazy var loadingQueue: KinoInteractorLoadingQueue? = {
        return KinoInteractorLoadingQueue(delegate: self)
    }()
    var genres: Genres
    var moviesList: [SectionType: Movies]

    init(presenter: HomeScenePresenterInput?) {
        self.presenter = presenter
        self.genres = Genres()
        self.moviesList = [SectionType: Movies]()
    }

    private func getPopularMovies() {
        loadingQueue?.add(.popularMovies)
        kinoAPI.getPopularMovies { result in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.moviesList.updateValue(moviesInfo.movies, forKey: .popular)
                    self?.presenter?.popularMoviesModelUpdated(movies: moviesInfo.movies, title: .popular)
                    self?.loadingQueue?.remove(task: .popularMovies)
                }
            case .failure(let error):
                print("\(#function) \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.loadingQueue?.remove(task: .popularMovies)
                }
            }
        }
    }

    private func getTrendingMovies() {
        loadingQueue?.add(.trendingMovies)
        kinoAPI.getTrendingMovies { result in
            switch result {
            case .success(let moviesInfo):
                DispatchQueue.main.async { [weak self] in
                    self?.moviesList.updateValue(moviesInfo.movies, forKey: .trending)
                    self?.presenter?.trendingMoviesModelUpdated(movies: moviesInfo.movies, title: .trending)
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

    private func getMoviesListCategories() {
        loadingQueue?.add(.movieCategoryList)
        kinoAPI.getMovieListCategory { (result) in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async { [weak self] in
                    self?.genres.append(contentsOf: movieList.genres)
                    self?.presenter?.modelCategoryUpdated(movieCategories: movieList, title: .moviesCategory)
                    self?.loadingQueue?.remove(task: .movieCategoryList)
                }
            case .failure(let error):
                print("\(#function) \(error)")
                DispatchQueue.main.async { [weak self] in
                    self?.loadingQueue?.remove(task: .movieCategoryList)
                }
            }
        }
    }
}

extension HomeSceneInteractor: HomeSceneInteractorInput {
    func loadContent() {
        getPopularMovies()
        getTrendingMovies()
        getMoviesListCategories()
    }
}

extension HomeSceneInteractor: KinoInteractorLoadingQueueDelegate {
    func didStartLoading(queue: KinoInteractorLoadingQueue) {

    }

    func didFinishLoading(queue: KinoInteractorLoadingQueue) {
        presenter?.didFinishLoading()
    }
}
