//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import RxSwift
import WeatherSwiftSDK

/// View Model which handles business logic of the daily weather view.
final class DailyDetailsViewModel {
    // MARK: - Internal Properties
    var dailyDetailsModel = BehaviorSubject<DailyDetailsModel>(value: DailyDetailsModel(humidity: "",
                                                                                        wind: "",
                                                                                        sunset: "",
                                                                                        sunrise: ""))
}

// MARK: - Internal Funcs
extension DailyDetailsViewModel {
    /// Calls the manager in order to get daily weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        WeatherApiManager.shared.cityDetailsWeather(cityName: city) { [weak self] res, error in
            DispatchQueue.main.async {
                guard error == nil, let model = res?.dailyDetailsModel else { return }

                self?.dailyDetailsModel.onNext(model)
            }
        }
    }
}
