//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import WeatherSwiftSDK

// MARK: - Structs
/// Model used for daily details view.
struct DailyDetailsModel {
    var humidity: String?
    var wind: String?
    var sunset: String?
    var sunrise: String?
}

extension DailyDetailsResponse {
    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "HH:mm a"
    }

    // MARK: - Internal Properties
    /// Returns a model for daily details weather built with self.
    var dailyDetailsModel: DailyDetailsModel? {
        let sunsetTimeInterval = TimeInterval(self.sys.sunset)
        let sunriseTimeInterval = TimeInterval(self.sys.sunrise)
        let sunsetDate = Date(timeIntervalSince1970: sunsetTimeInterval)
        let sunriseDate = Date(timeIntervalSince1970: sunriseTimeInterval)

        return DailyDetailsModel(humidity: "\(self.main.humidity)",
                                 wind: "\(self.wind.speed)",
                                 sunset: sunsetDate.formattedDate(with: Constants.format),
                                 sunrise: sunriseDate.formattedDate(with: Constants.format))
    }
}

/// Model used for daily details view.
struct WeeklyDetailsModel {
    var list: [DailyWeather]
}

// MARK: - Internal Properties
extension WeeklyDetailsResponse {
    /// Returns a model about weekly weather.
    var weeklyDetailsModel: WeeklyDetailsModel? {
        return WeeklyDetailsModel(list: self.list)
    }
}
