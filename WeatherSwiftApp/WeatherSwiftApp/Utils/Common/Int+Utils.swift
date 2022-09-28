//
//  Int+Utils.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

/// Utility extension for `Int`to stores helpers.
extension Int {
    /// Returns the string description of a Float temperature.
    var tempDesccription: String {
        if self == 0 {
            return L10n.dash
        } else {
            return "\(self)" + L10n.degreesUnit
        }
    }
}
