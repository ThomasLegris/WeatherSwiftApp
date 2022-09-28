//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Coordinator which handles navigation for map.
final class MapCoodinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    func start() {
        let mapViewController = WeatherMapViewController.instantiate(coordinator: self)
        mapViewController.setupTabBar(title: L10n.map,
                                      image: Asset.icMapItemOff.image,
                                      selectedImage: Asset.icMapItemOn.image)
        self.navigationController = UINavigationController(rootViewController: mapViewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Internal Funcs
extension MapCoodinator {
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
extension MapCoodinator: WeatherDetailsViewControllerDelegate {
    func didClickOnDismiss() {
        self.dismiss()
    }
}
