//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import RealmSwift
import RxSwift
import WeatherSwiftSDK

/// View model which provides list of registered favorite cities.
final class FavoriteCitiesListViewModel {
    // MARK: - Internal Properties
    var favoriteCities = BehaviorSubject<[FavoriteCity]>(value: [])

    // MARK: - Private Properties
    private var dataBase = CityDataBaseManager.shared
    private var notificationToken: NotificationToken?

    // MARK: - Init
    init() {
        observeCities()
    }

    // MARK: - Deinit
    deinit {
        notificationToken = nil
    }
}

// MARK: - Private Funcs
private extension FavoriteCitiesListViewModel {
    /// Add observer on cities database.
    func observeCities() {
        notificationToken = dataBase.cities?.observe { [weak self] _ in
            self?.updateDatas()
        }
        updateDatas()
    }

    /// Update data source.
    func updateDatas() {
        favoriteCities.onNext(dataBase.cities?.elements ?? [])
    }
}
