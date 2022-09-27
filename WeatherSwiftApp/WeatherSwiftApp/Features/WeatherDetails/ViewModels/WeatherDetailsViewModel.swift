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
    func updateCity(with name: String, completion: () -> Void) {
        persistanceManager.updateCity(cityName: name) { isSuccess in
            if isSuccess {
                completion()
            }
        }
    }
}
