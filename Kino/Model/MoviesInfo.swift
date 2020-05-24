//
//  MoviesInfo.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

typealias Movies = [Movie]

// MARK: - MoviesInfo
struct MoviesInfo: Codable {
    let page, totalResults, totalPages: Int
    let movies: Movies

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let imageURL: String?
    let movieId: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIDS: [Int]?
    let title: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case imageURL = "poster_path"
        case movieId = "id"
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
