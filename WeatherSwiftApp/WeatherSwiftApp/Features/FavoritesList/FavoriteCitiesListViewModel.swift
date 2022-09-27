//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import CoreData
import WeatherSwiftSDK
import Foundation

/// View model which provides list of registered favorite cities.
final class FavoriteCitiesListViewModel {
    // MARK: - Internal Properties
    var favoriteCitiesObs: Observable<[City]> = Observable(value: [])

    // MARK: - Private Properties
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    private let persistanceManager: PersistanceProtocol

    // MARK: - Init
    init(persistanceManager: PersistanceProtocol) {
        self.persistanceManager = persistanceManager
        observeCities()
    }

    deinit {
        // For safety, remove observers which has been init here.
        notificationCenter.removeObserver(self)
    }
}

// MARK: - Private Funcs
private extension FavoriteCitiesListViewModel {
    /// Add observer on cities database.
    func observeCities() {
        notificationCenter.addObserver(self,
                                       selector: #selector(updateDatas),
                                       name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                       object: persistanceManager.context)
        updateDatas()
    }

    /// Update data source.
    @objc func updateDatas() {
        favoriteCitiesObs.value = PersistanceManager.shared.cities
    }
}
