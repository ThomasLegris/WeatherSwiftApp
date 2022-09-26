//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit

/// Coordinator which handles navigation logic for Home screens.
final class HomeCoordinator: Coordinator {
    // MARK: - Internal Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?

    // MARK: - Internal Funcs
    func start() {
        let homeViewController = HomeViewController.instantiate(coordinator: self)
        self.navigationController = UINavigationController(rootViewController: homeViewController)
        self.navigationController?.isNavigationBarHidden = true
    }
}
