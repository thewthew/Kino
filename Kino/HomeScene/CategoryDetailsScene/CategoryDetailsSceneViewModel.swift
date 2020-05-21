//
//  CategoryDetailsSceneViewModel.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

enum CategoryDetailsSceneViewModel {

    struct Title {
        let title: String
    }

    struct Section: Hashable {
        let movies: [MovieCell]
    }

    struct MovieCell: Hashable {
        let title: String
        let releaseDate: String
        let posterUrlString: String?
        let description: String

        init(title: String, releaseDate: String, posterUrlString: String? = nil, description: String) {
            self.title = title
            self.releaseDate = releaseDate
            self.posterUrlString = posterUrlString
            self.description = description
        }
    }
}
