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

    @IBOutlet weak var moviesCollectionView: UICollectionView!

    // MARK: - Properties
    private var sections: [HomeSceneViewModel.Section]? = [HomeSceneViewModel.Section]()
    private lazy var dataSource = makeDataSource()

    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>

    var interactor: HomeSceneInteractorInput?
    var viewModel: HomeSceneViewModel.Content? {
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
        moviesCollectionView.registerSupplementaryView(registrableClass: SectionHeaderReusableView.self,
                                                       kind: UICollectionView.elementKindSectionHeader)
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    private func updateViewContent() {
        guard let sectionViewModel = viewModel?.section else {
            return
        }
        sections?.append(sectionViewModel)
        applySnapshot(animatingDifferences: true)
    }

    func makeDataSource() -> DataSource {
      let dataSource =
        DataSource(
            collectionView: moviesCollectionView,
            cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reusableID, for: indexPath)
                if let movieCell = cell as? MovieCell {
                    movieCell.model = movie
                }
                return cell
        })
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderReusableView.reusableID,
                for: indexPath) as? SectionHeaderReusableView
            sectionHeaderView?.model = section
            return sectionHeaderView
        }
      return dataSource
    }

    private func configureLayout() {
        moviesCollectionView.collectionViewLayout =
            UICollectionViewCompositionalLayout(sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
                let size = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(280)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 3)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .estimated(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                  layoutSize: headerSize,
                  elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = [sectionHeader]

                return section
            })
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        guard let sections = sections else {
            return
        }
        let sortedSections = sections.sorted {
            switch ($0.titleSection, $1.titleSection) {
            case (.popular, .trending):
                return true
            case (.trending, .popular):
                return false
            default: return true
            }
        }

        snapshot.appendSections(sortedSections)
        sortedSections.forEach { section in
            snapshot.appendItems(section.movies, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

}

extension HomeSceneViewController: HomeSceneViewControllerInput {
    func viewModelUpdated(_ viewModel: HomeSceneViewModel.Content) {
        self.viewModel = viewModel
    }
}
