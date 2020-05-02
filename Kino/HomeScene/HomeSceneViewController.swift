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

final class HomeSceneViewController: UICollectionViewController {

    // MARK: - Properties
    private var sections: [HomeSceneViewModel.Section]?
    private lazy var dataSource = makeDataSource()

    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSceneViewModel.Section, HomeSceneViewModel.MovieCell>

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
        collectionView.register(registrableClass: MovieCell.self)
//        collectionView.register(registrableClass: SectionHeaderReusableView.self)
//        let nib = UINib(nibName: "SectionHeaderReusableView", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: SectionHeaderReusableView.reusableID)
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadContent()
    }

    private func updateViewContent() {
        sections = viewModel?.section
        applySnapshot(animatingDifferences: false)
    }

    func makeDataSource() -> DataSource {
      let dataSource = DataSource(collectionView: collectionView,
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
        let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        let view = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: SectionHeaderReusableView.reusableID,
          for: indexPath) as? SectionHeaderReusableView
        view?.titleLabel.text = section.titleSection
        return view
      }
      return dataSource
    }

    private func configureLayout() {
      collectionView.collectionViewLayout =
        UICollectionViewCompositionalLayout(sectionProvider: { (_, _)
            -> NSCollectionLayoutSection? in
        let size = NSCollectionLayoutSize(
          widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
          heightDimension: NSCollectionLayoutDimension.absolute(280)
        )
        let itemCount = 3
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10
        return section
      })
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
    func viewModelUpdated(_ viewModel: HomeSceneViewModel.Content) {
        self.viewModel = viewModel
    }
}
