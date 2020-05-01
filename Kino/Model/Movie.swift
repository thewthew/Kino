//
//  Movie.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

typealias Movies = [Movie]
typealias ProductionCompanies = [ProductionCompany]
typealias ProductionCountries = [ProductionCountry]
typealias SpokenLanguages = [SpokenLanguage]

// MARK: - Welcome
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let movieId: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: ProductionCompanies
    let productionCountries: ProductionCountries
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: SpokenLanguages
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage
        case movieId = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let genreId: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name = "name"
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let productionCompanyId: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case productionCompanyId = "id"
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639, name: String

    enum CodingKeys: String, CodingKey {
        case iso639 = "iso_639_1"
        case name
    }
}
