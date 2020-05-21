//
//  MovieDetailsSceneViewController.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol MovieDetailsSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: MovieDetailsSceneViewModel.Content)
}

final class MovieDetailsSceneViewController: UIViewController {

    @IBOutlet weak var movieDetailsCollectionView: UICollectionView!

    // MARK: - Properties
    private var sections: [MovieDetailsSceneViewModel.Section]? = [MovieDetailsSceneViewModel.Section]()
    private lazy var dataSource = makeDataSource()

    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<MovieDetailsSceneViewModel.Section, MovieDetailsSceneViewModel.Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieDetailsSceneViewModel.Section, MovieDetailsSceneViewModel.Cell>

    var interactor: MovieDetailsSceneInteractorInput?
    var viewModel: MovieDetailsSceneViewModel.Content? {
        didSet { updateViewContent() }
    }
    var sectionsViewModel: [MovieDetailsSceneViewModel.Section]?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initScene()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initScene()
    }

    private func initScene() {
        interactor = MovieDetailsSceneInteractor(presenter: MovieDetailsScenePresenter(viewController: self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsCollectionView.register(registrableClass: MovieDetailImageCell.self)
        movieDetailsCollectionView.register(registrableClass: MovieDetailBasicInfoCell.self)
        movieDetailsCollectionView.register(registrableClass: MovieDetailOverviewCell.self)
        configureLayout()
        interactor?.loadContent()
    }

    private func updateViewContent() {
        title = viewModel?.title
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        guard let sections = sections else {
            return
        }
        snapshot.appendSections(sections)
        sections.forEach {
            guard let cells = $0.cells else { return }
            snapshot.appendItems(cells, toSection: $0)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func configureLayout() {
        movieDetailsCollectionView.collectionViewLayout =
            UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = self.sections?[sectionIndex].modelType
            switch sectionLayoutKind {
            case .image:
                return self.generateCoverImageSection()
            case .basicInfo:
                return self.generateBasicInfoSection()
            case .overview:
                return self.generateOverviewSection()
            default:
                return nil
            }
        })
    }

    private func generateCoverImageSection() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }

    private func generateBasicInfoSection() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }

    private func generateOverviewSection() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        return NSCollectionLayoutSection(group: group)
    }
 }

extension MovieDetailsSceneViewController: MovieDetailsSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: MovieDetailsSceneViewModel.Content) {
        self.viewModel = viewModel
        viewModel.sections?.forEach({ (section) in
            sections?.append(section)
        })
        applySnapshot(animatingDifferences: true)

    }
}

// MARK: - TableView datasource
extension MovieDetailsSceneViewController {
    func makeDataSource() -> DataSource {
        let dataSource =
            DataSource(
                collectionView: self.movieDetailsCollectionView,
                cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                    switch self.sections?[indexPath.section].modelType {
                    case .image:
                        let cell =
                            collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailImageCell.reusableID, for: indexPath)
                        if let imageCell = cell as? MovieDetailImageCell {
                            imageCell.model = movie as? MovieDetailsSceneViewModel.ImageCellViewModel
                        }
                        return cell

                    case .basicInfo:
                        let cell =
                            collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailBasicInfoCell.reusableID, for: indexPath)
                        if let basicCell = cell as? MovieDetailBasicInfoCell {
                            basicCell.model = movie as? MovieDetailsSceneViewModel.BasicInfoViewModel
                        }
                        return cell

                    case .overview:
                        let cell =
                            collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailOverviewCell.reusableID, for: indexPath)
                        if let overviewCell = cell as? MovieDetailOverviewCell {
                            overviewCell.model = movie as? MovieDetailsSceneViewModel.OverviewViewModel
                        }
                        return cell

                    default:
                        return UICollectionViewCell()
                    }
            })
        return dataSource
    }
}
