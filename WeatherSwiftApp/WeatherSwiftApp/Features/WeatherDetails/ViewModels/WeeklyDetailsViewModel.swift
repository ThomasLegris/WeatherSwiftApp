//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import WeatherSwiftSDK

/// View Model which handle business logic of the daily weather view.
final class WeeklyDetailsViewModel {
    // MARK: - Internal Properties
    var weeklyDetailsModelObs: Observable<WeeklyDetailsModel> = Observable(value: WeeklyDetailsModel(list: []))

    // MARK: - Private Properties
    private let apiManager: ApiManagerProtocol

    // MARK: - Init
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
}

// MARK: - Internal Funcs
extension WeeklyDetailsViewModel {
    /// Calls the manager in order to get weekly weather information.
    ///
    /// - Parameters:
    ///     - city: name of the city
    func requestWeather(city: String) {
        apiManager.cityWeeklyWeather(cityName: city) { [weak self] res, error in
            DispatchQueue.main.async {
                guard error == nil, let model = res?.weeklyDetailsModel else { return }

                self?.weeklyDetailsModelObs.value = model
            }
        }
    }
}
