//
//  TodaySceneViewController.swift
//  Kino
//
//  Created by Matti on 23/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol TodaySceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: TodaySceneViewModel.Content)
    func openMovieDetails(with url: URL)
}

final class TodaySceneViewController: UIViewController {

    @IBOutlet weak var todayMovieImageView: CustomImageView!
    @IBOutlet weak var todayMovieTitleLabel: UILabel!
    @IBOutlet weak var todayMovieDescriptionLabel: UILabel!

    var interactor: TodaySceneInteractorInput?
    var viewModel: TodaySceneViewModel.Content?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initScene()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initScene()
    }

    private func initScene() {
        interactor = TodaySceneInteractor(presenter: TodayScenePresenter(viewController: self))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    @IBAction func didTapWigetButton(_ sender: UIButton) {
        interactor?.openMovieDetails()
    }
}

extension TodaySceneViewController: TodaySceneViewControllerInput {
    func openMovieDetails(with url: URL) {
        extensionContext?.open(url, completionHandler: nil)
    }

    func viewModelUpdated(_ viewModel: TodaySceneViewModel.Content) {
        self.viewModel = viewModel
        todayMovieImageView.loadImage(with: viewModel.moviePosterURL)
        todayMovieTitleLabel.text = viewModel.movieTitle
        todayMovieDescriptionLabel.text = viewModel.movieDescription
    }
}
