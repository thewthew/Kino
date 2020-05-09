//
//  WatchListScenePresenterTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class WatchListScenePresenterTests: XCTestCase {
    var viewControllerSpy: WatchListSceneViewControllerSpy!
    var presenterUnderTesting: WatchListScenePresenter!

    override func setUp() {
        super.setUp()
        viewControllerSpy = WatchListSceneViewControllerSpy()
        presenterUnderTesting = WatchListScenePresenter(viewController: viewControllerSpy)
    }
}
