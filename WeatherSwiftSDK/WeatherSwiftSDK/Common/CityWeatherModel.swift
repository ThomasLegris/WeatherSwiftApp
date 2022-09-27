//
//  CityWeatherModel.swift
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 27/09/2022.
//

import Foundation

/// Represents a city as simple swift object
/// Also a usefull wrapper of `City` object. Avoid using a CoreData object in whole app.
public struct CityWeatherModel: Codable {
    // MARK: - Public Properties
    public var name: String
    public var imageName: String
    public var weatherDescription: String
    public var temperature: Float

    // MARK: - Init
    public init(name: String, imageName: String, weatherDescription: String, temperature: Float) {
        self.name = name
        self.imageName = imageName
        self.weatherDescription = weatherDescription
        self.temperature = temperature
    }
}
