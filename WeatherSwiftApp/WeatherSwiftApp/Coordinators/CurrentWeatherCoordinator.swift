//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Coordinator which handles navigation for current weather screens.
final class CurrentWeatherCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    // MARK: - Internal Funcs
    func start() {
        let currentWeatherViewController = CurrentWeatherViewController.instantiate(coordinator: self)
        currentWeatherViewController.setupTabBar(title: L10n.home,
                                                 image: Asset.icCurrentWeatherItemOff.image,
                                                 selectedImage: Asset.icCurrentWeatherItemOn.image)
        self.navigationController = UINavigationController(rootViewController: currentWeatherViewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Internal Funcs
extension CurrentWeatherCoordinator {
    /// Displays details screen.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    func displayDetails(with weatherModel: CityWeatherModel) {
        let viewController = WeatherDetailsViewController.instantiate(coordinator: self, weatherModel: weatherModel)
        present(viewController)
    }
}
