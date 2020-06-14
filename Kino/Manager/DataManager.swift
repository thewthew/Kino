//
//  DataManager.swift
//  Kino
//
//  Created by Matti on 06/06/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit
import CoreData

protocol DataManagerInjected { }
extension DataManagerInjected {
    var dataManager: DataManager { return DataManager.shared }
}

class DataManager: NSObject {
    public static let shared = DataManager()

    private enum Entity: String {
        case movie

        var name: String {
            switch self {
            case .movie: return "MovieRecord"
            }
        }
    }

    func isFavorite(_ idMovie: Int) -> Bool {
        guard let movies = fetchMovies() else { return false }
        return movies.contains(where: { $0.movieId == idMovie })
    }

    func removeMovie(_ idMovieToRemove: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.movie.name)

        if let savedMovie = try? managedContext.fetch(fetchRequest) {
            let idMatchingMovie = savedMovie.first { (movieEntity) -> Bool in
                guard let movieRecord = movieEntity as? MovieRecord else { return false }
                return idMovieToRemove == Int(movieRecord.movieId)
            }
            guard let movieToRemove = idMatchingMovie else { return }
            managedContext.delete(movieToRemove)
        }
    }

    func storeMovie(_ movieToSave: Movie) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        let movieRecord = MovieRecord(context: managedContext)
        movieRecord.title = movieToSave.title
        movieRecord.imageURL = movieToSave.imageURL
        movieRecord.movieId = Int32(movieToSave.movieId)
        movieRecord.overview = movieToSave.overview
        movieRecord.releaseDate = movieToSave.releaseDate

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save COREData app context. \(error), \(error.userInfo)")
        }
    }

    func fetchMovies() -> Movies? {
        var favoriteSavedMovies = Movies()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return favoriteSavedMovies
        }
        let managedContext =  appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.movie.name)

        if let savedMovies = try? managedContext.fetch(fetchRequest) {
            favoriteSavedMovies = savedMovies.compactMap { (movieEntity) -> Movie? in
                guard let movieRecorded = movieEntity as? MovieRecord else { return nil }
                return movieEntityToMovie(movieRecorded)
            }
        } else {
            print("Could not get saved CoreData data")
        }
        return favoriteSavedMovies
    }

    func movieEntityToMovie(_ recordedMovie: MovieRecord) -> Movie {
        let restoredMovie = Movie.init(popularity: 0.0,
                                       voteCount: 0,
                                       video: true,
                                       imageURL: recordedMovie.imageURL,
                                       movieId: Int(recordedMovie.movieId),
                                       adult: false,
                                       backdropPath: nil,
                                       originalLanguage: "",
                                       originalTitle: "",
                                       genreIDS: nil,
                                       title: recordedMovie.title ?? "",
                                       voteAverage: 0.0,
                                       overview: recordedMovie.overview ?? "",
                                       releaseDate: recordedMovie.releaseDate)

        return restoredMovie
    }
}
