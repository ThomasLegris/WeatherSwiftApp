//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import WeatherSwiftSDK
import Foundation

/// View model which provides list of registered favorite cities.
final class FavoriteCitiesListViewModel {
    // MARK: - Internal Properties
    var favoriteCitiesObs: Observable<[CityWeatherModel]> = Observable(value: [])
    /// Returns true if connected to internet, false otherwise.
    var isNetworkReachable: Bool {
        return Reachability.isConnectedToNetwork()
    }

    // MARK: - Private Properties
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    private let persistanceManager: PersistanceManagerProtocol

    // MARK: - Init
    init(persistanceManager: PersistanceManagerProtocol) {
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateDatas),
                                               name: .favoriteCitiesHasChanged,
                                               object: nil)
        updateDatas()
    }

    /// Update data source.
    @objc func updateDatas() {
        favoriteCitiesObs.value = persistanceManager.favoriteCityModels
    }
}
