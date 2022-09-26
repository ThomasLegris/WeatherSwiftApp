//
//  Copyright (C) 2020 Thomas LEGRIS.
//

/// Files which provides several OpenWeatherMap response models.

// MARK: - Structs
/// Model for a city weather response.
public struct LocalWeatherResponse: Codable {
    // MARK: - Public Properties
    public var weather: [WeatherField]?
    public var main: MainField
    public var name: String
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name
    }
}

/// Model for the `weather` field in the JSON Response.
public struct WeatherField: Codable {
    public var identifier: Int
    public var main: String
    public var icon: String
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main
        case icon
    }
}

/// Model for the `main` field in the JSON Response.
public struct MainField: Codable {
    public var temp: Float
    public var pressure: Float
    public var humidity: Float
    public var tempMin: Float
    public var tempMax: Float
    
    // MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
