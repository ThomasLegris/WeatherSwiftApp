//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit

/// Screen which allows user to select different screens.
final class HomeViewController: UITabBarController {
    // MARK: - Internal Properties
    weak var homeCoordinator: HomeCoordinator?

    // MARK: - Private Properties
    private var mapCoordinator: MapCoodinator = MapCoodinator()
    private var weatherCoordinator: CurrentWeatherCoordinator = CurrentWeatherCoordinator()
    private var favCitiesCoordinator: FavoriteCitiesCoordinator = FavoriteCitiesCoordinator()

    // MARK: - Setup
    static func instantiate(coordinator: HomeCoordinator?) -> HomeViewController {
        let viewController = StoryboardScene.Home.initialScene.instantiate()
        viewController.homeCoordinator = coordinator

        return viewController
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initGestures()
    }
}

// MARK: - Actions
private extension HomeViewController {
    /// Handles swip gestures.
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.selectedIndex += 1
        } else if sender.direction == .right {
            self.selectedIndex -= 1
        }
    }
}

// MARK: - Private Funcs
private extension HomeViewController {
    /// Inits view.
    func initView() {
        weatherCoordinator.start()
        favCitiesCoordinator.start()
        mapCoordinator.start()

        guard let weatherVC = weatherCoordinator.navigationController,
              let favCityVC = favCitiesCoordinator.navigationController,
              let mapVC = mapCoordinator.navigationController else { return }

        self.viewControllers = [weatherVC,
                                favCityVC,
                                mapVC]
    }

    /// Inits gesture recognizers.
    func initGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
}
