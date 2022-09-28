//
//  ApiManagerProtocol.swift
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 23/09/2022.
//
//

import Foundation

// MARK: - Protocols
/// Defines weather API methods.
public protocol ApiManagerProtocol {
    /// Gets global weather by city.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    ///     - completion: completion called after request providing response and/or optionnal error
    /// - Returns: A single element sequence with local response.
    func cityWeather(cityName: String,
                     completion: @escaping (_ response: LocalWeatherResponse?, _ error: WeatherApiError?) -> Void)

    /// Gets global weather by coordinates.
    ///
    /// - Parameters:
    ///     - latitude: latitude in degrees: [-90, 90]
    ///     - longitude: longitude in degrees: [-180, 180]
    ///     - completion: completion called after request providing response and/or optionnal error
    /// - Returns: A single element sequence with local response.
    func locationWeather(latitude: Double,
                         longitude: Double,
                         completion: @escaping (_ response: LocalWeatherResponse?, _ error: WeatherApiError?) -> Void)

    /// Gets details weather.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    ///     - completion: completion called after request providing response and/or optionnal error
    /// - Returns: A single element sequence with details response.
    func cityDetailsWeather(cityName: String, completion: @escaping (_ response: DailyDetailsResponse?,
                                                                     _ error: WeatherApiError?) -> Void)

    /// Gets next week weather.
    ///
    /// - Parameters:
    ///     - cityName: name of targetted city
    ///     - completion: completion called after request providing response and/or optionnal error
    /// - Returns: A single element sequence with weekly weather response.
    func cityWeeklyWeather(cityName: String,
                           completion: @escaping (_ response: WeeklyDetailsResponse?, _ error: WeatherApiError?) -> Void)
}
