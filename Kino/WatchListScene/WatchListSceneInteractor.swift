//
//  WatchListSceneInteractor.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

protocol WatchListSceneInteractorInput: class {
    func loadContent()
}

final class WatchListSceneInteractor {
    var presenter: WatchListScenePresenterInput?

    init(presenter: WatchListScenePresenterInput?) {
        self.presenter = presenter
    }
}

extension WatchListSceneInteractor: WatchListSceneInteractorInput {
    func loadContent() {

    }
}
