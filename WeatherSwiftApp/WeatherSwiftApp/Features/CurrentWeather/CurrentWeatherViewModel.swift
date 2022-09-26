//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import MapKit
import WeatherSwiftSDK

/// View Model which handle business logic of the current weather screen.
final class CurrentWeatherViewModel {
    // MARK: - Internal Properties
    var weatherModelObs: Observable<CommonWeatherModel> = Observable(value: CommonWeatherModel(temperature: nil,
                                                                                               icon: nil,
                                                                                               description: L10n.dash,
                                                                                               cityName: L10n.dash))
    var weatherErrorObs: Observable<WeatherError> = Observable(value: .none)
    var updatedDateObs: Observable<String> = Observable(value: "")
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

        WeatherApiManager
            .shared
            .cityWeather(cityName: cityName, completion: { [weak self] res, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    guard error == nil else {
                        self.weatherErrorObs.value = .noInfo
                        return
                    }
                    guard let model = res?.commonWeatherModel else {
                        self.weatherErrorObs.value = .unknownCity
                        return
                    }
                    UserDefaults.standard.set(model.cityName, forKey: UserDefaultKeys.lastSearchedCity.rawValue)
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

        WeatherApiManager
            .shared
            .locationWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] res, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    guard error == nil else {
                        self.weatherErrorObs.value = .noInfo
                        return
                    }

                    guard let model = res?.commonWeatherModel else {
                        self.weatherErrorObs.value = .unknownCity
                        return
                    }
                    self.weatherErrorObs.value = .none
                    self.weatherModelObs.value = model
                }
            }
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewModel {
    /// Returns true if connected to internet, false otherwise.
    var isNetworkReachable: Bool {
        return Reachability.isConnectedToNetwork()
    }

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
