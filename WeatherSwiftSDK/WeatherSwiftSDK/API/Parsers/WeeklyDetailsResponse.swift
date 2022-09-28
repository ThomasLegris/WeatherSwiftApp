//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import Foundation

// MARK: - Structs
/// Provides an OpenWeatherMap codable model to handle weekly details API response.
public struct WeeklyDetailsResponse: Codable {
    // MARK: - Public Properties
    public var list: [DailyWeather]

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case list
    }
}

/// Model for the `list` field in the JSON Response.
public struct DailyWeather: Codable {
    /// Date of the current field.
    public var date: Int
    /// Main field.
    public var main: MainField
    /// Weather field.
    public var weather: [WeatherField]

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
    }
}
