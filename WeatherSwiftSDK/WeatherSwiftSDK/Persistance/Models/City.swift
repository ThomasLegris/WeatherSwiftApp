//
//  WeatherSwiftSDK
//
//  Created by Thomas Legris on 26/09/2022.
//

import Foundation
import CoreData

/// Represents a city as Core data object.
/// The extension file is auto generated.
public class City: NSManagedObject {
    // MARK: - Helpers
    /// Returns an entity model
    /// Used to avoid working with CoreData object.
    public var model: CityModel {
        return CityModel(name: self.name ?? "",
                         imageName: self.imageName ?? "",
                         weatherDescription: self.weatherDescription ?? "",
                         temperature: self.temperature)
    }
}
