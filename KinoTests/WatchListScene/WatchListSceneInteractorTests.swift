//
//  WatchListSceneInteractorTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class WatchListSceneInteractorTests: XCTestCase {
    var presenterSpy: WatchListScenePresenterSpy!
    var interactorUnderTesting: WatchListSceneInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = WatchListScenePresenterSpy()
        interactorUnderTesting = WatchListSceneInteractor(presenter: presenterSpy)
    }
}
