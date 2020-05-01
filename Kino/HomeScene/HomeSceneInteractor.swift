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
}

final class HomeSceneInteractor {
    var presenter: HomeScenePresenterInput?

    init(presenter: HomeScenePresenterInput?) {
        self.presenter = presenter
    }
}

extension HomeSceneInteractor: HomeSceneInteractorInput {
    func loadContent() {

    }
}
