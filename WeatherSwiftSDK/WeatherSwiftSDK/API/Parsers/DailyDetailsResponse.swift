//
//  DailyDetailsResponse.swift
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation

// MARK: - Structs
/// Provides an OpenWeatherMap codable model to handle daily details API response.
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
