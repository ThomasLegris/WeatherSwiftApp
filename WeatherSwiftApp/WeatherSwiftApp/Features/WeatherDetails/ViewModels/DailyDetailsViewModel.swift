//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import WeatherSwiftSDK

/// View Model which handles business logic of the daily weather view.
final class DailyDetailsViewModel {
    // MARK: - Internal Properties
    var dailyDetailsModelObs: Observable<DailyDetailsModel> = Observable(value: DailyDetailsModel(humidity: "",
                                                                                                  wind: "",
                                                                                                  sunset: "",
                                                                                                  sunrise: ""))

    // MARK: - Private Properties
    private let apiManager: ApiManagerProtocol

    // MARK: - Init
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
}

// MARK: - Internal Funcs
extension DailyDetailsViewModel {
    /// Calls the manager in order to get daily weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        apiManager.cityDetailsWeather(cityName: city) { [weak self] res, error in
            DispatchQueue.main.async {
                guard error == nil, let model = res?.dailyDetailsModel else { return }

                self?.dailyDetailsModelObs.value = model
            }
        }
    }
}
