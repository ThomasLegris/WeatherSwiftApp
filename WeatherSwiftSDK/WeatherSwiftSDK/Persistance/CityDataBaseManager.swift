//
//  CityDataBaseManager.swift
//  WeatherSwiftSDK
//
//  Created by Consultant on 23/09/2022.
//
//

import RealmSwift

/// Manager to handle favorite cities operation in database.
public final class CityDataBaseManager {
    // MARK: - Public Properties
    /// Shared instance of the manager.
    public static let shared: CityDataBaseManager = CityDataBaseManager()

    /// Retrive cities from data base.
    public var cities: Results<FavoriteCity>? {
        return myDataBase?.objects(FavoriteCity.self)
    }

    // MARK: - Private Properties
    private var myDataBase: Realm?

    // MARK: - Init
    private init() {
        do {
            myDataBase = try Realm()
        } catch {
            print("Error on database configuration")
        }
    }

    // MARK: - Public Funcs
    /// Updates selected city in the cities database.
    ///
    /// - Parameters:
    ///     - cityName: name of the city to add or remove
    public func updateCity(cityName: String?) {
        guard let cityName = cityName,
              !cityName.isEmpty else {
            return
        }

        if isCityRegistered(cityName: cityName) {
            deleteCity(with: cityName)
        } else {
            addCity(with: cityName)
        }
    }

    /// Returns true if the current city is registered the database.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    public func isCityRegistered(cityName: String?) -> Bool {
        guard let cityName = cityName,
              !cityName.isEmpty else {
            return false
        }

        return (cities?.first { $0.cityName == cityName }) != nil
    }
}

// MARK: - Private Funcs
private extension CityDataBaseManager {
    /// Adds a city in data base.
    ///
    /// - Parameters:
    ///     - cityName: name of the city to add
    func addCity(with cityName: String) {
        let city: FavoriteCity = FavoriteCity()
        city.cityName = cityName
        try? myDataBase?.write {
            myDataBase?.add(city)
        }
    }

    /// Deletes a city in data base.
    ///
    /// - Parameters:
    ///     - cityName: name of the city to remove
    func deleteCity(with cityName: String) {
        try? myDataBase?.write {
            guard let city = (cities?.first { $0.cityName == cityName }) else {
                return
            }

            myDataBase?.delete(city)
        }
    }
}
