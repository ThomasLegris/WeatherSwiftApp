//
//  WeatherApiManager.swift
//  WeatherSwiftSDK
//
//  Created by Consultant on 23/09/2022.
//
//

import Foundation

/// Weather Api manager which uses Moya framework.
public final class WeatherApiManager {
    // MARK: - Public Properties
    public static let shared: WeatherApiManager = WeatherApiManager()

    /// Returns the Open Weather Map API Key.
    var apiKey: String {
        // Find Api plist file.
        guard let filePath = Bundle.main.path(forResource: "OWM-info", ofType: "plist") else {
            fatalError("No API plist file")
        }

        // Find the Api key.
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "api_key") as? String else {
            fatalError("No api_key for OWMap")
        }
        return value
    }

    // MARK: - Private Enums
    private enum Constants {
        static let tempUnit: String = "metric"
        static let cityParam: String = "q"
        static let unitsParam: String = "units"
        static let keyParam: String = "appid"
        static let latParam: String = "lat"
        static let longParam: String = "lon"
    }

    // MARK: - Init
    private init() { }
}

// MARK: - WeatherApi
extension WeatherApiManager: ApiManagerProtocol {
    public func cityWeather(cityName: String, completion: @escaping (LocalWeatherResponse?, Error?) -> Void) {
        let params = [Constants.cityParam: cityName,
                      Constants.unitsParam: Constants.tempUnit,
                      Constants.keyParam: apiKey]
        guard let request = urlRequest(weatherService: WeatherService.currentWeather,
                                       params: params) else {
            completion(nil, WeatherApiError.badURL)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let responseData = data else {
                completion(nil, WeatherApiError.noData)
                return
            }

            let decoder = JSONDecoder()

            do {
                let jsonResponse = try decoder.decode(LocalWeatherResponse.self, from: responseData)

                guard jsonResponse.weather?.first != nil else {
                    completion(nil, WeatherApiError.jsonParsingError)
                    return
                }

                completion(jsonResponse, nil)
            } catch let decodeError {
                print(decodeError)
                completion(nil, decodeError)
            }
        }.resume()
    }

    public func locationWeather(latitude: Double, longitude: Double, completion: @escaping (LocalWeatherResponse?, Error?) -> Void) {
        let params: [String: Any] = [Constants.latParam: latitude,
                                     Constants.longParam: longitude,
                                     Constants.unitsParam: Constants.tempUnit,
                                     Constants.keyParam: WeatherApiManager.shared.apiKey]

        guard let request = urlRequest(weatherService: WeatherService.weatherByCoordinate,
                                       params: params) else {
            completion(nil, WeatherApiError.badURL)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let responseData = data else {
                completion(nil, WeatherApiError.noData)
                return
            }

            let decoder = JSONDecoder()

            do {
                let jsonResponse = try decoder.decode(LocalWeatherResponse.self, from: responseData)

                completion(jsonResponse, nil)
            } catch let decodeError {
                print(decodeError)
                completion(nil, decodeError)
            }
        }.resume()
    }

    public func cityDetailsWeather(cityName: String, completion: @escaping (DailyDetailsResponse?, Error?) -> Void) {
        let params = [Constants.cityParam: cityName,
                      Constants.unitsParam: Constants.tempUnit,
                      Constants.keyParam: apiKey]
        guard let request = urlRequest(weatherService: WeatherService.currentWeather,
                                       params: params) else {
            completion(nil, WeatherApiError.badURL)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let responseData = data else {
                completion(nil, WeatherApiError.noData)
                return
            }

            let decoder = JSONDecoder()

            do {
                let jsonResponse = try decoder.decode(DailyDetailsResponse.self, from: responseData)

                completion(jsonResponse, nil)
            } catch let decodeError {
                print(decodeError)
                completion(nil, decodeError)
            }
        }.resume()
    }

    public func cityWeeklyWeather(cityName: String, completion: @escaping (WeeklyDetailsResponse?, Error?) -> Void) {
        let params = [Constants.cityParam: cityName,
                      Constants.unitsParam: Constants.tempUnit,
                      Constants.keyParam: apiKey]
        guard let request = urlRequest(weatherService: WeatherService.weeklyWeather,
                                       params: params) else {
            completion(nil, WeatherApiError.badURL)
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let responseData = data else {
                completion(nil, WeatherApiError.noData)
                return
            }

            let decoder = JSONDecoder()

            do {
                let jsonResponse = try decoder.decode(WeeklyDetailsResponse.self, from: responseData)

                completion(jsonResponse, nil)
            } catch let decodeError {
                print(decodeError)
                completion(nil, decodeError)
            }
        }.resume()
    }
}

// MARK: - Private Funcs
private extension WeatherApiManager {
    /// Create an url with url components.
    ///
    /// - Parameters:
    ///    - endPoint: end point target
    ///    - params: json dict of query
    /// - Returns: The entire builded url.
    func urlRequest(weatherService: WeatherService, params: [String: Any] = [:]) -> URLRequest? {
        var components = URLComponents(string: weatherService.url)
        components?.queryItems = params.map { element in
            URLQueryItem(name: element.key, value: "\(element.value)") }

        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = weatherService.httpMethod
        return request
    }
}
