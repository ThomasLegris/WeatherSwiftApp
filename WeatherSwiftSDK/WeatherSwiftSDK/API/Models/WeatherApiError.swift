//
//  WeatherApiError.swift
//  WeatherSwiftSDK
//
//  Created by Consultant on 24/09/2022.
//

import Foundation

// MARK: - Public Enums
/// Stores potential errors which could occur during an API call.
enum WeatherApiError: Error {
    case noData
    case badURL
    case jsonParsingError
}
