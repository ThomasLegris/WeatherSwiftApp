//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 27/09/2022.
//

import Foundation

// MARK: - Protocols
/// Protocol used to store persistance related method.
/// Could be inherited from several Managers.
public protocol PersistanceManagerProtocol {
    /// Managed object context to manipulate all core data entities.
    /// Notes: Type is Any to not access to CoreData objects outside the module.
    var context: Any { get }

    /// Returns all citie objects.
    var favoriteCityModels: [CityWeatherModel] { get }

    // MARK: - Public Funcs
    /// Add or remove a city in DB.
    ///
    /// - Parameters:
    ///     - city: the targetted coredata city object
    ///     - completion: operation result as bool
    func addOrRemoveCity(city: CityWeatherModel?, completion: (Bool) -> Void)

    /// Update a city which is in database.
    ///
    /// - Parameters:
    ///     - city: the targetted coredata city object
    ///     - completion: operation result as bool
    func updateCity(city: CityWeatherModel?, completion: (Bool) -> Void)

    /// Checks if a city is registered into the DB.
    ///
    /// - Parameters:
    ///     - cityName: the targetted city name
    /// - Returns: true if city is already in DB
    func isCityRegistered(cityName: String?) -> Bool
}
