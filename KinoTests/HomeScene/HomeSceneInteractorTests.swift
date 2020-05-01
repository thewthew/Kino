//
//  HomeSceneInteractorTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeSceneInteractorTests: XCTestCase {
    var presenterSpy: HomeScenePresenterSpy!
    var interactorUnderTesting: HomeSceneInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = HomeScenePresenterSpy()
        interactorUnderTesting = HomeSceneInteractor(presenter: presenterSpy)
    }
}
