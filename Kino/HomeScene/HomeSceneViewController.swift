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
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    private func updateViewContent() {
        viewModel?.forEach({ (viewModel) in
            sections?.append(viewModel.section)
        })
        applySnapshot(animatingDifferences: true)
    }

    func makeDataSource() -> DataSource {
      let dataSource =
        DataSource(
            collectionView: moviesCollectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                let sectionType = SectionType.allCases.sorted()[indexPath.section]
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
                let sectionLayoutKind = SectionType.allCases.sorted()[sectionIndex]
                switch sectionLayoutKind {
                case .popular, .trending:
                    return self?.generateMoviesLayoutSection()
                case .moviesCategory:
                    return self?.generateMoviesCategoryLayoutSection()
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

extension HomeSceneViewController: HomeSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: [HomeSceneViewModel.Content]) {
        self.viewModel = viewModel
    }
}
