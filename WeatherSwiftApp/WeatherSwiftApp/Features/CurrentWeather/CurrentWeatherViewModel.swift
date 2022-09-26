//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import SwiftyUserDefaults
import Reachability
import MapKit
import RxSwift
import WeatherSwiftSDK

/// View Model which handle business logic of the current weather screen.
final class CurrentWeatherViewModel {
    // MARK: - Internal Properties
    var weatherModel = BehaviorSubject<CommonWeatherModel>(value: CommonWeatherModel(temperature: nil,
                                                                                     icon: nil,
                                                                                     description: L10n.dash,
                                                                                     cityName: L10n.dash))
    var weatherError = BehaviorSubject<WeatherError>(value: .none)
    var updatedDate = BehaviorSubject<String>(value: "")
    
    // MARK: - Private Properties
    private let disposeBag = DisposeBag()
}

// MARK: - Internal Funcs
extension CurrentWeatherViewModel {
    /// Call the manager in order to get weather information.
    ///
    /// - Parameters:
    ///     - city: city name requested by user
    func requestWeather(with city: String?) {
        guard isNetworkReachable else {
            weatherError.onNext(.noInternet)
            return
        }
        
        guard let cityName = city,
              city?.isEmpty == false else {
            weatherError.onNext(.unknownCity)
            return
        }
        
        WeatherApiManager
            .shared
            .cityWeather(cityName: cityName, completion: { [weak self] res, error in
                DispatchQueue.main.async {
                    guard error == nil else {
                        self?.weatherError.onNext(.noInfo)
                        return
                    }
                    guard let model = res?.commonWeatherModel else {
                        self?.weatherError.onNext(.unknownCity)
                        return
                    }
                    Defaults.lastSearchedCity = model.cityName
                    
                    self?.weatherModel.onNext(model)
                    self?.updateDate()
                }
            })
    }
    
    /// Call the manager in order to get weather information from coordinate.
    ///
    /// - Parameters:
    ///     - coordinate: map pointer location
    func requestWeather(with coordinate: CLLocationCoordinate2D?) {
        guard isNetworkReachable else {
            weatherError.onNext(.noInternet)
            return
        }
        
        guard let coordinate = coordinate else {
            weatherError.onNext(.noInfo)
            return
        }
        
        WeatherApiManager
            .shared
            .locationWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] res, error in
                DispatchQueue.main.async {
                    guard error == nil, let self = self else {
                        self?.weatherError.onNext(.noInfo)
                        return
                    }
                    
                    guard let model = res?.commonWeatherModel else {
                        self.weatherError.onNext(.unknownCity)
                        return
                    }
                    self.weatherModel.onNext(model)
                }
            }
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewModel {
    /// Returns true if connected to internet, false otherwise.
    var isNetworkReachable: Bool {
        let reachability = try? Reachability()
        
        return reachability?.connection == .wifi ||  reachability?.connection == .cellular
    }
    
    /// Update weather last updated time in hour.
    func updateDate() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        updatedDate.onNext(formatter.string(from: currentDateTime))
        Defaults.lastUpdatedDate = try? updatedDate.value()
    }
}
