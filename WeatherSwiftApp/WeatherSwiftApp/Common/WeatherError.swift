//
//  WeatherError.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

/// Stores different weather request error.
enum WeatherError {
    case noInternet
    case noInfo
    case unknownCity
    case none

    var title: String {
        switch self {
        case .noInternet:
            return L10n.commonWarning
        default:
            return L10n.commonError
        }
    }

    var message: String {
        switch self {
        case .noInternet:
            return L10n.errorNoInternet
        case .unknownCity:
            return L10n.errorUnknownCity
        default:
            return L10n.errorNoInfo
        }
    }
}
