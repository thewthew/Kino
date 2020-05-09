//
//  CodableExtensions.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation

extension Decodable {
    static func fromJSON(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = dateStr.parseWSDate() {
                return date
            }
            if let date = dateStr.parseWSLongUTCDate() {
                return date
            }
            if let date = dateStr.parseWSUTCDate() {
                return date
            }
            if let date = dateStr.parseShortDate() {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot parse date")
        }
        return try decoder.decode(self, from: data)
    }

    static func fromJSON(string: String) -> Self? {
        guard let data = string.data(using: .utf8) else { return nil }
        do {
            return try fromJSON(data: data)
        } catch let error {
            print(error)
        }
        return nil
    }

    static func fromJSON(dictionary: Any) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        return try? fromJSON(data: data)
    }
}
