//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import MapKit
import WeatherSwiftSDK

/// View Model which handle business logic of the current weather screen.
final class CurrentWeatherViewModel {
    // MARK: - Internal Properties
    var weatherModelObs: Observable<CityWeatherModel> = Observable(value: CityWeatherModel(name: L10n.dash,
                                                                                           imageName: "",
                                                                                           weatherDescription: L10n.dash,
                                                                                           temperature: 0.0))
    var weatherErrorObs: Observable<WeatherError> = Observable(value: .none)
    var updatedDateObs: Observable<String> = Observable(value: "")
    /// Returns true if connected to internet, false otherwise.
    var isNetworkReachable: Bool {
        return Reachability.isConnectedToNetwork()
    }

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
extension CurrentWeatherViewModel {
    /// Call the manager in order to get weather information.
    ///
    /// - Parameters:
    ///     - city: city name requested by user
    func requestWeather(with city: String?) {
        guard isNetworkReachable else {
            self.weatherErrorObs.value = .noInternet
            return
        }

        guard let cityName = city,
              city?.isEmpty == false else {
            self.weatherErrorObs.value = .unknownCity
            return
        }

        apiManager.cityWeather(cityName: cityName, completion: { [weak self] res, error in
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
                UserDefaults.standard.set(model.name, forKey: UserDefaultKeys.lastSearchedCity.rawValue)
                self.persistanceManager.updateCity(city: model)
                self.weatherErrorObs.value = .none
                self.weatherModelObs.value = model
                self.updateDate()
            }
        })
    }

    /// Call the manager in order to get weather information from coordinate.
    ///
    /// - Parameters:
    ///     - coordinate: map pointer location
    func requestWeather(with coordinate: CLLocationCoordinate2D?) {
        guard isNetworkReachable else {
            self.weatherErrorObs.value = .noInternet
            return
        }

        guard let coordinate = coordinate else {
            self.weatherErrorObs.value = .noInfo
            return
        }

        apiManager.locationWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] res, error in
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

                self.persistanceManager.updateCity(city: model)
                self.weatherErrorObs.value = .none
                self.weatherModelObs.value = model
            }
        }
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewModel {
    /// Update weather last updated time in hour.
    func updateDate() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        updatedDateObs.value = formatter.string(from: currentDateTime)
        UserDefaults.standard.set(updatedDateObs.value, forKey: UserDefaultKeys.lastUpdatedDate.rawValue)
    }
}
