//
//  MovieDetailsSceneViewModel.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

enum MovieDetailSectionType: Hashable {
    case image
    case basicInfo
    case overview
    case cast
    case recommandation
}

enum MovieDetailsSceneViewModel {
    struct Content {
        let title: String?
        let sections: [Section]?
        let iconName: String

        static func == (lhs: MovieDetailsSceneViewModel.Content, rhs: MovieDetailsSceneViewModel.Content) -> Bool {
            return true
        }
        private let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }

    }

    struct Section: Hashable {
        let modelType: MovieDetailSectionType?
        let cells: [Cell]?

        static func == (lhs: MovieDetailsSceneViewModel.Section, rhs: MovieDetailsSceneViewModel.Section) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    class Cell: Hashable {
        static func == (lhs: MovieDetailsSceneViewModel.Cell, rhs: MovieDetailsSceneViewModel.Cell) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    class ImageCellViewModel: Cell {
        var imageURL: String?
        init(imageURL: String? = nil) {
            self.imageURL = imageURL
        }
    }

    class BasicInfoViewModel: Cell {
        var title: String
        init(title: String) {
            self.title = title
        }
    }

    class OverviewViewModel: Cell {
        var title: String
        var description: String
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
}
