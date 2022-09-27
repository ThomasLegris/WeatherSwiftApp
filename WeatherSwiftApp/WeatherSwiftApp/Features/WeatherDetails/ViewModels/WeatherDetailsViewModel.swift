//
//  WeatherDetailsViewModel.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 27/09/2022.
//

import Foundation
import WeatherSwiftSDK

/// Handles business logic for weather details view.
final class WeatherDetailsViewModel {
    // MARK: - Private Properties
    private let persistanceManager: PersistanceManagerProtocol

    // MARK: - Init
    init(persistanceManager: PersistanceManagerProtocol) {
        self.persistanceManager = persistanceManager
    }
}

// MARK: - Internal Funcs
extension WeatherDetailsViewModel {
    /// Update the city
    func addOrRemoveCity(with weatherModel: CommonWeatherModel, completion: () -> Void) {
        guard let name = weatherModel.cityName,
              let imageName = weatherModel.icon,
              let weatherDescription = weatherModel.description,
              let temperature = weatherModel.temperature else { return }
        let cityModel = CityModel(name: name,
                                  imageName: imageName,
                                  weatherDescription: weatherDescription,
                                  temperature: temperature)

        persistanceManager.addOrRemoveCity(city: cityModel) { isSuccess in
            if isSuccess {
                completion()
            }
        }
    }
}
