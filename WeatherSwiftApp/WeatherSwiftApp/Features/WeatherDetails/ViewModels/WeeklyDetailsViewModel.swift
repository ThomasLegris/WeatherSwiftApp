//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import SwiftyUserDefaults
import RxSwift
import WeatherSwiftSDK

/// View Model which handle business logic of the daily weather view.
final class WeeklyDetailsViewModel {
    // MARK: - Internal Properties
    var dailyDetailsModel = BehaviorSubject<WeeklyDetailsModel>(value: WeeklyDetailsModel(list: []))
}

// MARK: - Internal Funcs
extension WeeklyDetailsViewModel {
    /// Calls the manager in order to get weekly weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        WeatherApiManager.shared.cityWeeklyWeather(cityName: city) { [weak self] res, error in
            DispatchQueue.main.async {
                guard error == nil, let model = res?.weeklyDetailsModel else { return }
                
                self?.dailyDetailsModel.onNext(model)
            }
        }
    }
}
