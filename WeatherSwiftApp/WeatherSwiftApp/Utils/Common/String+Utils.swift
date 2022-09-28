//
//  String+Utils.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

/// Utility extension of `String`.
extension String {
    /// Returns true if current string is not empty.
    var isNotEmpty: Bool {
        return self.isEmpty == false
    }

    /// Checks for string name validity.
    var isValidCityName: Bool {
        return self.isNotEmpty && self != L10n.dash
    }
}
