//
//  HomeSceneViewModel.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

enum HomeSceneViewModel {

    struct Content: Hashable {
        let section: [Section]
    }

    struct Section: Hashable {
        let titleSection: String
        let movies: [MovieCell]
    }

    struct MovieCell: Hashable {
        let title: String
        let posterUrlString: String
    }
}
