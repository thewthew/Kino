//
//  MovieDetailOverviewCell.swift
//  Kino
//
//  Created by Matti on 16/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class MovieDetailOverviewCell: UICollectionViewCell, UICollectionViewCellRegistrable {

    @IBOutlet weak var titleOverviewLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var model: MovieDetailsSceneViewModel.OverviewViewModel! {
        didSet {
            config()
        }
    }

    private func config() {
        titleOverviewLabel.text = model.title
        overviewLabel.text = model.description
    }

}
