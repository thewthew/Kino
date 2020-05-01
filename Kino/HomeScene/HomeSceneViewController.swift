//
//  HomeSceneViewController.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol HomeSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: HomeSceneViewModel.Content)
}

final class HomeSceneViewController: UIViewController {

    var interactor: HomeSceneInteractorInput?
    var viewModel: HomeSceneViewModel.Content? {
        didSet { updateViewContent() }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initScene()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initScene()
    }

    private func initScene() {
        interactor = HomeSceneInteractor(presenter: HomeScenePresenter(viewController: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadContent()
    }

    private func updateViewContent() {

    }

}

extension HomeSceneViewController: HomeSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: HomeSceneViewModel.Content) {
        self.viewModel = viewModel
    }
}
