//
//  SectionHeaderReusableView.swift
//  Kino
//
//  Created by Matti on 02/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView, UICollectionViewCellRegistrable {

    @IBOutlet weak var titleLabel: UILabel!

    var model: HomeSceneViewModel.Section! {
        didSet {
            config()
        }
    }
    private func config() {
        titleLabel.text = model.titleSection.rawValue
    }
}
