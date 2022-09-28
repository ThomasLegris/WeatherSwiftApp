//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Coordinator which handles navigation for favorite cities list.
final class FavoriteCitiesCoordinator: Coordinator {
    // MARK: - Internal Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    // MARK: - Internal Funcs
    func start() {
        let viewModel = FavoriteCitiesListViewModel(persistanceManager: PersistanceManager.shared)
        let viewController = FavoriteCitiesListViewController.instantiate(viewModel: viewModel)
        viewController.delegate = self
        viewController.setupTabBar(title: L10n.favoriteList,
                                   image: Asset.icFavItemOff.image,
                                   selectedImage: Asset.icFavItemOn.image)
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - CommonViewControllerDelegate
extension FavoriteCitiesCoordinator: CommonViewControllerDelegate {
    func didClickOnDetails(weatherModel: CityWeatherModel) {
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
