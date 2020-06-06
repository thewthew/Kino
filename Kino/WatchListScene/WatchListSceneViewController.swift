//
//  WatchListSceneViewController.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol WatchListSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: WatchListSceneViewModel.Content)
}

final class WatchListSceneViewController: UIViewController {

    var interactor: WatchListSceneInteractorInput?
    var viewModel: WatchListSceneViewModel.Content? {
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
        interactor = WatchListSceneInteractor(presenter: WatchListScenePresenter(viewController: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    private func updateViewContent() {

    }

}

extension WatchListSceneViewController: WatchListSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: WatchListSceneViewModel.Content) {
        self.viewModel = viewModel
    }
}
