//
//  Float+Utils.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

/// Utility extension for `Float`to stores helpers.
extension Float {
    /// Returns the string description of a Float temperature.
    var tempDesccription: String {
        if self == 0.0 {
            return L10n.dash
        } else {
            let temperatureInteger = Int(self)
            return temperatureInteger.tempDesccription
        }
    }
}
