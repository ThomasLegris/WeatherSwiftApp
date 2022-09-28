//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 26/09/2022.
//

import Foundation
import CoreData

/// Core data object of city.
/// The extension file is auto generated.
public class City: NSManagedObject {
    // MARK: - Helpers
    /// Returns an entity `CityWeatherModel`
    /// Used to avoid working with CoreData object.
    public var model: CityWeatherModel {
        return CityWeatherModel(name: self.name ?? "",
                                imageName: self.imageName ?? "",
                                weatherDescription: self.weatherDescription ?? "",
                                temperature: self.temperature)
    }
}
