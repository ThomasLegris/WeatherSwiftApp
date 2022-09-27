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

    // MARK: - Init
    private init() {}
}

// MARK: - PersistanceProtocol
extension PersistanceManager: PersistanceProtocol {
    public var context: Any {
        return CoreDataStack.shared.viewContext
    }

    public var cities: [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        guard let objectContext = contextView,
              let cities = try? objectContext.fetch(request) else {
            return []
        }
        return cities
    }

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


    public func isCityRegistered(cityName: String?) -> Bool {
        guard let cityName = cityName, !cityName.isEmpty else {
            return false
        }
        return cities.first(where: { $0.name == cityName }) != nil
    }
}

private extension PersistanceManager {
    // MARK: - Private Properties
    var contextView: NSManagedObjectContext? {
        return context as? NSManagedObjectContext
    }

    // MARK: - Private Funcs
    /// Add a city in coredata database.
    func addCity(cityName: String, completion: (Bool) -> Void) {
        guard let objectContext = contextView else {
            completion(false)
            return
        }
        let city = City(context: objectContext)
        city.name = cityName
        do {
            try objectContext.save()
            completion(true)
        } catch {
            print("Unable to save city in database")
            completion(false)
        }
    }

    /// Remove selected city from coredata database.
    func removeCity(cityName: String, completion: (Bool) -> Void) {
        guard let objectContext = contextView else {
            completion(false)
            return
        }
        if let city = cities.first(where: { $0.name == cityName }) {
            do {
                objectContext.delete(city)
                try objectContext.save()
                completion(true)
            } catch {
                print("Unable to remove city in database")
                completion(false)
            }
        }
    }
}
