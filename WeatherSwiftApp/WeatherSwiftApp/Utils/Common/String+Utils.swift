//
//  String+Utils.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        return self.isEmpty == false
    }

    var isValidCityName: Bool {
        return self.isNotEmpty && self != L10n.dash
    }
}
