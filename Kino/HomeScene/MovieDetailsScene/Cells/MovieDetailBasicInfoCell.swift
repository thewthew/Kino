//
//  MovieDetailBasicInfoCell.swift
//  Kino
//
//  Created by Matti on 16/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class MovieDetailBasicInfoCell: UICollectionViewCell, UICollectionViewCellRegistrable {

    @IBOutlet weak var titleLabel: UILabel!

    var model: MovieDetailsSceneViewModel.BasicInfoViewModel! {
        didSet {
            config()
        }
    }

    private func config() {
        titleLabel.text = model.title
    }
}
