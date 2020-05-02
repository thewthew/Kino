//
//  UICollectionViewExtensions.swift
//  Kino
//
//  Created by Matti on 02/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol UICollectionViewCellRegistrable {
    static var nibName: String { get }
    static var reusableID: String { get }
}

extension UICollectionViewCellRegistrable {
    static var nibName: String {
        return Self.reusableID
    }
    static var reusableID: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCellRegistrable>(registrableClass: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        self.register(nib, forCellWithReuseIdentifier: T.reusableID)
    }
    func registerHeaderFooterView<T: UICollectionViewCellRegistrable>(registrableClass: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        self.register(nib, forCellWithReuseIdentifier: T.reusableID)
    }
}
