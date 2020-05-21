//
//  HomeSceneViewController.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol HomeSceneViewControllerInput: class {
    func viewModelUpdated(_ viewModel: [HomeSceneViewModel.Content])
}

final class HomeSceneViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    // MARK: - Properties
    private var sections: [HomeSceneViewModel.Section]? = [HomeSceneViewModel.Section]()
    private lazy var dataSource = makeDataSource()

    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>

    private struct SegueId {
        static let goToMovieDetails = "goToMovieDetails"
        static let goToCollectionDetails = "goToMovieCategories"
    }

    var interactor: HomeSceneInteractorInput?
    var viewModel: [HomeSceneViewModel.Content]? {
        didSet { updateViewContent() }
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
        moviesCollectionView.register(registrableClass: MovieCell.self)
        moviesCollectionView.register(registrableClass: CategoryCell.self)
        moviesCollectionView.registerSupplementaryView(registrableClass: SectionHeaderReusableView.self,
                                                       kind: UICollectionView.elementKindSectionHeader)
        moviesCollectionView.delegate = self
        configureLayout()
        interactor?.loadContent()
    }

    private func updateViewContent() {
        viewModel?.forEach({ (viewModel) in
            sections?.append(viewModel.section)
        })
        applySnapshot(animatingDifferences: true)
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
                let indexPath = sender as? IndexPath,
                let sectionType = sections?[indexPath.section].titleSection,
                let movies = interactor?.moviesList[sectionType],
                indexPath.row < movies.count {
                destVC.interactor?.movie = movies[indexPath.row]
            }
        case SegueId.goToCollectionDetails:
            if let destVC = segue.destination as? CategoryDetailsSceneViewController,
                let indexPath = sender as? IndexPath,
                let genre = interactor?.genres[indexPath.row] {
                destVC.interactor?.genre = genre
            }
        default: break
        }
    }
}

extension HomeSceneViewController: HomeSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: [HomeSceneViewModel.Content]) {
        self.viewModel = viewModel
    }
}

// MARK: - Collectionview datasource
extension HomeSceneViewController {
    func makeDataSource() -> DataSource {
      let dataSource =
        DataSource(
            collectionView: moviesCollectionView,
            cellProvider: { [weak self] (collectionView, indexPath, movie) -> UICollectionViewCell? in
                let sectionType = self?.sections?[indexPath.section].titleSection
                switch sectionType {
                case .popular:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusableID, for: indexPath)
                    if let movieCell = cell as? MovieCell {
                        movieCell.model = movie
                    }
                    return cell

                case .trending:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusableID, for: indexPath)
                    if let movieCell = cell as? MovieCell {
                        movieCell.model = movie
                    }
                    return cell

                case .moviesCategory:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reusableID, for: indexPath)
                    if let movieCell = cell as? CategoryCell {
                        movieCell.model = movie
                    }
                    return cell
                case .none:
                    return UICollectionViewCell()
                }
        })

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let sectionHeaderView =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                withReuseIdentifier: SectionHeaderReusableView.reusableID,
                                                                for: indexPath) as? SectionHeaderReusableView
            sectionHeaderView?.model = section
            return sectionHeaderView
        }
      return dataSource
    }

    private func configureLayout() {
        moviesCollectionView.collectionViewLayout =
            UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
                let sectionLayoutKind = self?.sections?[sectionIndex].titleSection
                switch sectionLayoutKind {
                case .popular, .trending:
                    return self?.generateMoviesLayoutSection()
                case .moviesCategory:
                    return self?.generateMoviesCategoryLayoutSection()
                default:
                    return nil
                }
            })
    }

    private func generateMoviesLayoutSection() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(280))

        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 2)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(66))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func generateMoviesCategoryLayoutSection() -> NSCollectionLayoutSection? {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))

        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 4)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(66))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}

// MARK: - Collectionview delegate
extension HomeSceneViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections?[indexPath.section].titleSection
        switch section {
        case .popular, .trending:
            performSegue(withIdentifier: SegueId.goToMovieDetails, sender: indexPath)
        case .moviesCategory:
            performSegue(withIdentifier: SegueId.goToCollectionDetails, sender: indexPath)
        default:
            break
        }
    }
}
