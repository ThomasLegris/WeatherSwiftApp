//
//  WeatherService.swift
//  WeatherSwiftSDK
//
//  Created by Consultant on 23/09/2022.
//
//

import Foundation

// MARK: - Public Enums
/// Moya service for weather API.
enum WeatherService {
    /// Gets current weather with city name.
    case currentWeather
    /// Get weather by coordinate.
    case weatherByCoordinate
    /// Gets weekly weather with city name.
    case weeklyWeather
}

extension WeatherService {
    // MARK: - Private Enums
    private enum Constants {
        static let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
    }
    
    var url: String {
        var path: String = ""
        switch self {
        case .currentWeather,
                .weatherByCoordinate:
            path = "weather"
        case .weeklyWeather:
            path = "forecast"
        }
        return Constants.baseUrl + path
    }
    
    var httpMethod: String {
        return "GET"
    }
}
