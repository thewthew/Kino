//
//  HomeScenePresenterTests.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import XCTest
@testable import Kino

class HomeScenePresenterTests: XCTestCase {
    var viewControllerSpy: HomeSceneViewControllerSpy!
    var presenterUnderTesting: HomeScenePresenter!

    override func setUp() {
        super.setUp()
        viewControllerSpy = HomeSceneViewControllerSpy()
        presenterUnderTesting = HomeScenePresenter(viewController: viewControllerSpy)
    }
}
