//
//  CategoryDetailsSceneViewController.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol CategoryDetailsSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: CategoryDetailsSceneViewModel.Title)
    func moviesModelUpated(_ viewModel: CategoryDetailsSceneViewModel.Section)
}

final class CategoryDetailsSceneViewController: UIViewController {

    @IBOutlet weak var moviesGenreTableView: UITableView!

    typealias DataSource = UITableViewDiffableDataSource<CategoryDetailsSceneViewModel.Section, CategoryDetailsSceneViewModel.MovieCell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategoryDetailsSceneViewModel.Section, CategoryDetailsSceneViewModel.MovieCell>

    private struct SegueId {
        static let goToMovieDetails = "goToMovieDetails"
    }

    private var sections: [CategoryDetailsSceneViewModel.Section]? = [CategoryDetailsSceneViewModel.Section]()
    private lazy var dataSource = makeDataSource()
    var interactor: CategoryDetailsSceneInteractorInput?
    var viewModel: CategoryDetailsSceneViewModel.Title?
    var moviesViewModel: CategoryDetailsSceneViewModel.Section?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initScene()
    }

    private func initScene() {
        interactor = CategoryDetailsSceneInteractor(presenter: CategoryDetailsScenePresenter(viewController: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesGenreTableView.register(registrableClass: MovieCategoryCell.self)
        moviesGenreTableView.dataSource = dataSource
        moviesGenreTableView.delegate = self
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case SegueId.goToMovieDetails:
            if let destVC = segue.destination as? MovieDetailsSceneViewController,
                let indexPath = sender as? IndexPath {
                destVC.interactor?.movie = interactor?.moviesList[indexPath.row]
            }
        default:
            break
        }
    }
}

extension CategoryDetailsSceneViewController: CategoryDetailsSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: CategoryDetailsSceneViewModel.Title) {
        self.viewModel = viewModel
        title = viewModel.title
    }

    func moviesModelUpated(_ viewModel: CategoryDetailsSceneViewModel.Section) {
        self.moviesViewModel = viewModel
        sections?.append(viewModel)
        applySnapshot(animatingDifferences: false)
    }
}

// MARK: - TableView datasource
extension CategoryDetailsSceneViewController {
    func makeDataSource() -> DataSource {
        return UITableViewDiffableDataSource(tableView: moviesGenreTableView, cellProvider: { tableView, indexPath, movie in
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCategoryCell.reusableID, for: indexPath)
            if let movieCell = cell as? MovieCategoryCell {
                movieCell.model = movie
            }
            return cell
        })
    }
}

// MARK: - TableView delegate
extension CategoryDetailsSceneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueId.goToMovieDetails, sender: indexPath)
    }
}
