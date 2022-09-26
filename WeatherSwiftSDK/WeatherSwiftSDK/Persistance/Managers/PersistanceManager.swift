//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 26/09/2022.
//

import Foundation
import CoreData

/// Manager used to handle database operation.
/// Hide all core data request to other part of the app. Simply call public methods from here.
public class PersistanceManager {
    // MARK: - Public Properties
    public static let shared: PersistanceManager = PersistanceManager()

    /// Managed object context to manipulate all core data entities.
    public var context: NSManagedObjectContext {
        return CoreDataStack.shared.viewContext
    }

    /// Returns all citie objects.
    public var cities: [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        guard let cities = try? context.fetch(request) else {
            return []
        }
        return cities
    }

    // MARK: - Init
    private init() {}

    // MARK: - Public Funcs
    /// Add or remove a city in DB.
    ///
    /// - Parameters:
    ///     - cityName: the targetted city name
    ///     - completion: operation result as bool
    public func updateCity(cityName: String?, completion: (Bool) -> Void) {
        guard let cityName = cityName, !cityName.isEmpty else {
            completion(false)
            return
        }
        if isCityRegistered(cityName: cityName) {
            self.removeCity(cityName: cityName, completion: completion)
        } else {
            self.addCity(cityName: cityName, completion: completion)
        }
    }

    /// Checks if a city is registered into the DB.
    ///
    /// - Parameters:
    ///     - cityName: the targetted city name
    /// - Returns: true if city is already in DB
    public func isCityRegistered(cityName: String?) -> Bool {
        guard let cityName = cityName, !cityName.isEmpty else {
            return false
        }
        return cities.first(where: { $0.name == cityName }) != nil
    }
}

// MARK: - Private Funcs
private extension PersistanceManager {
    func addCity(cityName: String, completion: (Bool) -> Void) {
        let city = City(context: context)
        city.name = cityName
        do {
            try context.save()
            completion(true)
        } catch {
            print("Unable to save city in database")
            completion(false)
        }
    }

    func removeCity(cityName: String, completion: (Bool) -> Void) {
        if let city = cities.first(where: { $0.name == cityName }) {
            do {
                context.delete(city)
                try context.save()
                completion(true)
            } catch {
                print("Unable to remove city in database")
                completion(false)
            }
        }
    }
}
