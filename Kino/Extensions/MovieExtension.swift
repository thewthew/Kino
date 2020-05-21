//
//  MovieExtension.swift
//  Kino
//
//  Created by Matti on 02/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

extension Movie {
    var imageFullPathURL: String? {
        if let imageURL = imageURL {
            return "https://image.tmdb.org/t/p/original\(imageURL)"
        } else {
            return nil
        }
    }

    var releaseDateFormatted: String? { releaseDate?.formatReleaseDate() }

    var yearReleaseDate: String? { releaseDate?.formatYearReleaseDate() }
}
