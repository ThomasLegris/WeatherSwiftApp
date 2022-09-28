//
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 27/09/2022.
//

import Foundation

/// Extends notification to give notification custom names.
extension Notification.Name {
    /// Called when a city is added or removed from favorites list.
    static let favoriteCitiesHasChanged = Notification.Name("FavoriteCitiesHasChanged")
}
