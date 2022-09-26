//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

// MARK: - Structs
/// Model used for updating the custom widget view.
struct CommonWeatherModel: Equatable {
    // MARK: - Internal Properties
    var temperature: Float?
    var icon: UIImage?
    var description: String?
    var cityName: String?
}

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
    /// Returns a Common weather model built with self.
    var commonWeatherModel: CommonWeatherModel? {
        guard let weather = weather?[0] else { return CommonWeatherModel(temperature: 0.0,
                                                                         icon: Asset.icSun.image,
                                                                         description: "",
                                                                         cityName: "") }

        let weatherModel: CommonWeatherModel = CommonWeatherModel(temperature: main.temp,
                                                                  icon: self.groupFromId(identifier: weather.identifier).icon,
                                                                  description: weather.main,
                                                                  cityName: name)
        return weatherModel
    }
}

// MARK: - Public Enums
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
    var icon: UIImage {
        switch self {
        case .thunder:
            return Asset.icThunder.image
        case .rain,
             .drizzle:
            return Asset.icRain.image
        case .snow:
            return Asset.icSnow.image
        case .atmosphere:
            return Asset.icFog.image
        case .clear:
            return Asset.icSun.image
        case .clouds:
            return Asset.icSunCloudy.image
        }
    }
}

/// Stores different weather request error.
enum WeatherError {
    case noInternet
    case noInfo
    case unknownCity
    case none

    /// Error's title.
    var title: String {
        return L10n.commonError
    }

    /// Error's message.
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
