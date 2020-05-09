//
//  Manager.swift
//  Kino
//
//  Created by Matti on 01/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

struct ManagerInjectionMap {
    static var kinoAPI: KinoAPI = KinoAPI.shared

    static func reset() {
        ManagerInjectionMap.kinoAPI = KinoAPI.shared
    }
}
