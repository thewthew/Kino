//
//  CategoryCell.swift
//  Kino
//
//  Created by Matti on 08/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewCellRegistrable {

    @IBOutlet weak var categoryLabel: UILabel!

    var model: HomeSceneViewModel.MovieCell! {
        didSet {
            config()
        }
    }

    private func config() {
        categoryLabel.text = model.title
    }
}
