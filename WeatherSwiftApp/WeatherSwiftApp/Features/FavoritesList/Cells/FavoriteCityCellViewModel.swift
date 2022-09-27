//
//  FavoriteCityCellViewModel.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 27/09/2022.
//

import Foundation
import WeatherSwiftSDK

/// Handle logic for a selected favorite city (displayed in a cell).
final class FavoriteCityCellViewModel {
    // MARK: - Internal Properties
    var weatherModelObs: Observable<CityWeatherModel> = Observable(value: CityWeatherModel(name: L10n.dash,
                                                                                          imageName: "",
                                                                                          weatherDescription: L10n.dash,
                                                                                          temperature: 0.0))

    // MARK: - Private Properties
    private let apiManager: ApiManagerProtocol

    // MARK: - Init
    init(apiManager: ApiManagerProtocol) {
        self.apiManager = apiManager
    }
}

// MARK: - Internal Funcs
extension FavoriteCityCellViewModel {
    /// Call the manager in order to get weather information.
    ///
    /// - Parameters:
    ///     - city: city name requested by user
    func requestWeather(with city: String?) {
        guard let cityName = city,
              city?.isEmpty == false else {
            return
        }

        guard Reachability.isConnectedToNetwork() else {
            self.getWeatherFromDatabase(name: cityName)
            return
        }

        apiManager.cityWeather(cityName: cityName, completion: { [weak self] res, error in
                guard let self = self,
                        let model = res?.cityWeatherModel,
                        error == nil else { return }
                DispatchQueue.main.async {
                    self.weatherModelObs.value = model
                }
            })
    }
}

// MARK: - Private Funcs
private extension FavoriteCityCellViewModel {
    func getWeatherFromDatabase(name: String) {
        // TODO: Get info from favorite city in database
    }
}
