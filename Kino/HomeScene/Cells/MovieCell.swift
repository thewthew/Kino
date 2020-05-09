//
//  MovieCell.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell, UICollectionViewCellRegistrable {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: CustomImageView!

    var model: HomeSceneViewModel.MovieCell! {
        didSet {
            config()
        }
    }

    private func config() {
        movieTitleLabel.text = model.title
        if let url = model.posterUrlString {
            movieImageView.loadImage(with: url)
        } else {
            movieImageView.image = UIImage(named: "default-movie")
        }
    }
}
