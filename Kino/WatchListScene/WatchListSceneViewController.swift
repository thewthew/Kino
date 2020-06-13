//
//  WatchListSceneViewController.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol WatchListSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: WatchListSceneViewModel.Section)
}

final class WatchListSceneViewController: UIViewController {

    @IBOutlet weak var watchListTableView: UITableView!

    typealias DataSource = UITableViewDiffableDataSource<WatchListSceneViewModel.Section, WatchListSceneViewModel.MovieCell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WatchListSceneViewModel.Section, WatchListSceneViewModel.MovieCell>

    private var sections: [WatchListSceneViewModel.Section]? = [WatchListSceneViewModel.Section]()
    private lazy var dataSource = makeDataSource()
    var interactor: WatchListSceneInteractorInput?
    var viewModel: WatchListSceneViewModel.Section?

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
        watchListTableView.register(registrableClass: FavoriteMovieCell.self)
        watchListTableView.dataSource = makeDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        guard let sections = sections else {
            return
        }
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.movies, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension WatchListSceneViewController: WatchListSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: WatchListSceneViewModel.Section) {
        self.viewModel = viewModel
        sections = [viewModel]
        applySnapshot(animatingDifferences: false)
    }
}

// MARK: - TableView datasource
extension WatchListSceneViewController {
    func makeDataSource() -> DataSource {
        return UITableViewDiffableDataSource(tableView: watchListTableView, cellProvider: { tableView, indexPath, movie in
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reusableID, for: indexPath)
            if let movieCell = cell as? FavoriteMovieCell {
                movieCell.model = movie
            }
            return cell
        })
    }
}
