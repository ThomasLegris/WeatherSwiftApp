//
//  WeatherApiError.swift
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 24/09/2022.
//

import Foundation

// MARK: - Public Enums
/// Stores potential errors which could occur during an API call.
public enum WeatherApiError: Error {
    case httpError
    case noData
    case badURL
    case jsonParsingError
}
