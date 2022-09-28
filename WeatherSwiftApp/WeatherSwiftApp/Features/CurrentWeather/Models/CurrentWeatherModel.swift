//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

extension LocalWeatherResponse {
    /// Get weather group according to id.
    ///
    /// - Parameters:
    ///     - identifier: weather call response identifier
    /// - Returns: A weather group associated to its id.
    func groupFromId(identifier: Int) -> WeatherGroup {
        switch identifier {
        case 200...232:
            return .thunder
        case 300...321:
            return .drizzle
        case 500...531:
            return .rain
        case 600...622:
            return .snow
        case 701...781:
            return .atmosphere
        case 800:
            return .clear
        default:
            return .clouds
        }
    }

    // MARK: - Internal Properties
    /// Returns a city weather model with API response.
    var cityWeatherModel: CityWeatherModel? {
        guard let weather = weather?[0] else { return CityWeatherModel(name: L10n.dash,
                                                                       imageName: Asset.icSun.name,
                                                                       weatherDescription: L10n.dash,
                                                                       temperature: 0.0) }

        return CityWeatherModel(name: name,
                                imageName: self.groupFromId(identifier: weather.identifier).imageName,
                                weatherDescription: weather.main,
                                temperature: main.temp)
    }
}

// MARK: - Internal Enums
/// Provides different weather description.
enum WeatherGroup {
    case thunder
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds

    /// Icon corresponding to the current weather description.
    var imageName: String {
        switch self {
        case .thunder:
            return Asset.icThunder.name
        case .rain,
                .drizzle:
            return Asset.icRain.name
        case .snow:
            return Asset.icSnow.name
        case .atmosphere:
            return Asset.icFog.name
        case .clear:
            return Asset.icSun.name
        case .clouds:
            return Asset.icSunCloudy.name
        }
    }
}

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
