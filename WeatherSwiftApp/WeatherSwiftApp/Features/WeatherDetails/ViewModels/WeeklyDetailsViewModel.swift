//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import WeatherSwiftSDK

/// View Model which handle business logic of the daily weather view.
final class WeeklyDetailsViewModel {
    // MARK: - Internal Properties
    var weeklyDetailsModelObs: Observable<WeeklyDetailsModel> = Observable(value: WeeklyDetailsModel(list: []))

    /// Returns filtered list with only daily value (hourly value are skipped).
    var filteredList: [DailyWeather] {
        var filteredTab: [DailyWeather] = []
        let list = self.weeklyDetailsModelObs.value.list
        list.forEach { element in
            let formatter = DateFormatter()
            formatter.dateFormat = Constants.format
            guard let dateHour = Int(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(element.date)))) else { return }

            if Constants.afternoonTab.contains(dateHour) {
                filteredTab.append(element)
            }
        }

        return filteredTab
    }

    // MARK: - Private Properties
    private let apiManager: ApiManagerProtocol

    // MARK: - Private Enums
    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "HH"
        static let afternoonTab: [Int] = [13, 14, 15]
    }

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
