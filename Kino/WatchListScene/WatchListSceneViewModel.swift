//
//  WatchListSceneViewModel.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

enum WatchListSceneViewModel {

    struct Section: Hashable {
        let movies: [MovieCell]

        static func == (lhs: WatchListSceneViewModel.Section, rhs: WatchListSceneViewModel.Section) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    struct MovieCell: Hashable {
        let movieId: Int
        let title: String
        let releaseDate: String
        let posterUrlString: String?
        let description: String

        init(movieId: Int, title: String, releaseDate: String, posterUrlString: String? = nil, description: String) {
            self.movieId = movieId
            self.title = title
            self.releaseDate = releaseDate
            self.posterUrlString = posterUrlString
            self.description = description
        }

        static func == (lhs: WatchListSceneViewModel.MovieCell, rhs: WatchListSceneViewModel.MovieCell) -> Bool {
            return lhs.movieId == rhs.movieId
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(movieId)
        }
    }
}
