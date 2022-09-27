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

    // MARK: - Private Properties
    private var cities: [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        guard let objectContext = contextView,
              let cities = try? objectContext.fetch(request) else {
            return []
        }
        return cities

    }
    
    // MARK: - Init
    private init() {}
}

// MARK: - PersistanceManagerProtocol
extension PersistanceManager: PersistanceManagerProtocol {
    public var context: Any {
        return CoreDataStack.shared.viewContext
    }

    public var favoriteCityModels: [CityModel] {
        /// Returns non-nil models of core data city object.
        let cityModels = cities.compactMap { $0.model }
        return cityModels
    }

    public func updateCity(city: CityModel?, completion: (Bool) -> Void) {
        guard let cityName = city?.name,
              !cityName.isEmpty,
              self.isCityRegistered(cityName: cityName) else {
            completion(false)
            return
        }

        // TODO: update selected city object
    }

    public func addOrRemoveCity(city: CityModel?, completion: (Bool) -> Void) {
        guard let strongCity = city, !strongCity.name.isEmpty else {
            completion(false)
            return
        }
        if isCityRegistered(cityName: strongCity.name) {
            self.removeCity(cityName: strongCity.name, completion: completion)
        } else {
            self.addCity(cityModel: strongCity, completion: completion)
        }
    }

    public func isCityRegistered(cityName: String?) -> Bool {
        guard let cityName = cityName, !cityName.isEmpty else {
            return false
        }
        return favoriteCityModels.first(where: { $0.name == cityName }) != nil
    }
}

private extension PersistanceManager {
    // MARK: - Private Properties
    var contextView: NSManagedObjectContext? {
        return context as? NSManagedObjectContext
    }

    // MARK: - Private Funcs
    /// Add a city in coredata database.
    func addCity(cityModel: CityModel, completion: (Bool) -> Void) {
        guard let objectContext = contextView else {
            completion(false)
            return
        }
        let city = City(context: objectContext)
        city.name = cityModel.name
        city.imageName = cityModel.imageName
        city.weatherDescription = cityModel.weatherDescription
        city.temperature = cityModel.temperature

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
