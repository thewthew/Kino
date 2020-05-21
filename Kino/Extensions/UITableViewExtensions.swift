//
//  UITableViewExtensions.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import UIKit

protocol UITableViewCellRegistrable {
    static var nibName: String { get }
    static var reusableID: String { get }
}

extension UITableViewCellRegistrable {
    static var nibName: String {
        return Self.reusableID
    }
    static var reusableID: String {
        return String(describing: Self.self)
    }
}

extension UITableView {
    func register<T: UITableViewCellRegistrable>(registrableClass: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        self.register(nib, forCellReuseIdentifier: T.reusableID)
    }
    func registerHeaderFooterView<T: UITableViewCellRegistrable>(registrableClass: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        self.register(nib, forHeaderFooterViewReuseIdentifier: T.reusableID)
    }
}
