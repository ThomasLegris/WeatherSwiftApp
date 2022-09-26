//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import Foundation

/// Files which provides several OpenWeatherMap response models.
/// Only used for details screen.

// MARK: - Structs
/// Model for a city weather response.
public struct DailyDetailsResponse: Codable {
    public var main: MainField
    public var wind: WindField
    public var sys: SysField

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case main
        case wind
        case sys
    }

}

/// Model for the `wind` field in the JSON Response.
public struct WindField: Codable {
    public var speed: Float

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case speed
    }
}

/// Model for the `sys` field in the JSON Response.
public struct SysField: Codable {
    public var sunrise: Int
    public var sunset: Int

    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}

// MARK: - Weekly
/// Model for a city weather response.
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
