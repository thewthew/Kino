//
//  MovieCategoryCell.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class MovieCategoryCell: UITableViewCell, UITableViewCellRegistrable {

    @IBOutlet weak var movieImageView: CustomImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    var model: CategoryDetailsSceneViewModel.MovieCell! {
        didSet {
            config()
        }
    }

    private func config() {
        movieImageView.loadImage(with: model.posterUrlString)
        movieTitleLabel.text = model.title
        movieReleaseDateLabel.text = model.releaseDate
        movieDescriptionLabel.text = model.description
    }
}
