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
    func addOrRemoveCity(with weatherModel: CityWeatherModel, completion: () -> Void) {
        let cityModel = CityWeatherModel(name: weatherModel.name,
                                         imageName: weatherModel.imageName,
                                         weatherDescription: weatherModel.weatherDescription,
                                         temperature: weatherModel.temperature)

        persistanceManager.addOrRemoveCity(city: cityModel) { isSuccess in
            if isSuccess {
                completion()
            }
        }
    }
}
