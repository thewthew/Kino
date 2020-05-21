//
//  MovieDetailImageCell.swift
//  Kino
//
//  Created by Matti on 16/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class MovieDetailImageCell: UICollectionViewCell, UICollectionViewCellRegistrable {

    @IBOutlet weak var movieImageView: CustomImageView!

    var model: MovieDetailsSceneViewModel.ImageCellViewModel! {
        didSet {
            config()
        }
    }

    private func config() {
        movieImageView.loadImage(with: model.imageURL)
    }
}
