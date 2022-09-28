//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Coordinator which handles navigation for favorite cities list.
final class FavoriteCitiesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    func start() {
        let favoriteCitiesViewController = FavoriteCitiesListViewController.instantiate(coordinator: self)
        favoriteCitiesViewController.setupTabBar(title: L10n.favoriteList,
                                                 image: Asset.icFavItemOff.image,
                                                 selectedImage: Asset.icFavItemOn.image)
        self.navigationController = UINavigationController(rootViewController: favoriteCitiesViewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Internal Funcs
extension FavoriteCitiesCoordinator {
    /// Displays details screen.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    func displayDetails(with weatherModel: CityWeatherModel) {
        let detailsViewModel = WeatherDetailsViewModel(persistanceManager: PersistanceManager.shared)
        let viewController = WeatherDetailsViewController.instantiate(viewModel: detailsViewModel,
                                                                      weatherModel: weatherModel)
        viewController.delegate = self
        present(viewController)
    }
}

// MARK: - WeatherDetailsViewControllerDelegate
extension FavoriteCitiesCoordinator: WeatherDetailsViewControllerDelegate {
    func didClickOnDismiss() {
        self.dismiss()
    }
}
