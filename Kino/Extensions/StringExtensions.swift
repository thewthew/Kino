//
//  StringExtensions.swift
//  Kino
//
//  Created by Matti on 10/05/2020.
//  Copyright © 2020 Matti. All rights reserved.
//

import Foundation
extension String {
    func parseDate(format: String) -> Date? {
        return DateFormatter(withFormat: format, locale: "fr").date(from: self)
    }

    /// Date with format yyyy-MM-dd
    func parseWSDate() -> Date? {
        return parseDate(format: "yyyy-MM-dd")
    }

    /// Date with format yyyy-MM-dd'T'HH:mm:ssZZZ
    func parseWSUTCDate() -> Date? {
        return parseDate(format: "yyyy-MM-dd'T'HH:mm:ssZZZ")
    }

    /// Date with format yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ
    func parseWSLongUTCDate() -> Date? {
        return parseDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }

    /// Date with format dd/MM/yyyy
    func parseShortDate() -> Date? {
        return parseDate(format: "dd/MM/yyyy")
    }

    /// Date with format MMM d, yyyy
    func formatReleaseDate() -> String {
        return self.formatFromWSDate(format: "MMM d, yyyy")
    }

    /// Date with format YYYY
    func formatYearReleaseDate() -> String {
        return self.formatFromWSDate(format: "YYYY")
    }

    func formatFromWSDate(format: String) -> String {
        guard let dateFromString = parseWSDate() else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: dateFromString)
    }

}

extension DateFormatter {
    convenience init(withFormat format: String, locale: String) {
        self.init()
        self.locale = Locale(identifier: locale)
        dateFormat = format
    }
}
