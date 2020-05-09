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
    @IBOutlet weak var categoryImageView: UIImageView!

    var model: HomeSceneViewModel.MovieCell! {
        didSet {
            config()
        }
    }

    private func config() {
        categoryLabel.text = model.title
        categoryImageView.image = UIImage(named: model.title)
    }
}
