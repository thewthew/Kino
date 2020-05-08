//
//  MovieList.swift
//  Kino
//
//  Created by Matti on 08/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

typealias Genres = [Genre]
struct MovieList: Codable {
    let genres: Genres
}

// MARK: - Genre
struct Genre: Codable {
    let genreID: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case genreID = "id"
        case name = "name"
    }
}
