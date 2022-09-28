//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Coordinator which handles navigation for current weather screens.
final class CurrentWeatherCoordinator: Coordinator {
    // MARK: - Internal Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    // MARK: - Internal Funcs
    func start() {
        let viewModel = CurrentWeatherViewModel(apiManager: WeatherApiManager.shared,
                                                persistanceManager: PersistanceManager.shared)
        let viewController = CurrentWeatherViewController.instantiate(viewModel: viewModel)
        viewController.delegate = self
        viewController.setupTabBar(title: L10n.home,
                                   image: Asset.icCurrentWeatherItemOff.image,
                                   selectedImage: Asset.icCurrentWeatherItemOn.image)
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - CommonViewControllerDelegate
extension CurrentWeatherCoordinator: CommonViewControllerDelegate {
    func didClickOnDetails(weatherModel: CityWeatherModel) {
        let detailsViewModel = WeatherDetailsViewModel(persistanceManager: PersistanceManager.shared)
        let viewController = WeatherDetailsViewController.instantiate(viewModel: detailsViewModel,
                                                                      weatherModel: weatherModel)
        viewController.delegate = self
        present(viewController)
    }
}

// MARK: - WeatherDetailsViewControllerDelegate
extension CurrentWeatherCoordinator: WeatherDetailsViewControllerDelegate {
    func didClickOnDismiss() {
        self.dismiss()
    }
}
