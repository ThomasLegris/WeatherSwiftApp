//
//  MapAnnotationViewModel.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation
import WeatherSwiftSDK
import MapKit

/// Handle logic about the pin/annotation displayed on MapView.
class MapAnnotationViewModel {
    // MARK: - Internal Properties
    var weatherModelObs: Observable<CityWeatherModel> = Observable(value: CityWeatherModel(name: L10n.dash,
                                                                                           imageName: "",
                                                                                           weatherDescription: L10n.dash,
                                                                                           temperature: 0.0))
    var weatherErrorObs: Observable<WeatherError> = Observable(value: .none)

    // MARK: - Private Properties
    private let apiManager: ApiManagerProtocol
    private let persistanceManager: PersistanceManagerProtocol

    // MARK: - Init
    init(apiManager: ApiManagerProtocol, persistanceManager: PersistanceManagerProtocol) {
        self.apiManager = apiManager
        self.persistanceManager = persistanceManager
    }
}

// MARK: - Internal Funcs
extension MapAnnotationViewModel {
    /// Call the manager in order to get weather information from coordinate.
    ///
    /// - Parameters:
    ///     - coordinate: map pointer location
    func requestWeather(with coordinate: CLLocationCoordinate2D?) {
        guard Reachability.isConnectedToNetwork() else {
            self.weatherErrorObs.value = .noInternet
            return
        }

        guard let coordinate = coordinate else {
            self.weatherErrorObs.value = .noInfo
            return
        }

        apiManager.locationWeather(latitude: coordinate.latitude,
                                   longitude: coordinate.longitude) { [weak self] res, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard error == nil else {
                    self.weatherErrorObs.value = .noInfo
                    return
                }

                guard let model = res?.cityWeatherModel else {
                    self.weatherErrorObs.value = .unknownCity
                    return
                }

                self.weatherErrorObs.value = .none
                self.weatherModelObs.value = model
            }
        }
    }
}
