//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Screen which display details about a city weather.
final class WeatherDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var dailyDetailsView: DailyDetailsView!
    @IBOutlet private weak var weeklyDetailsView: WeeklyDetailsView!
    @IBOutlet private weak var detailsView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Internal Properties
    weak var coordinator: Coordinator?

    // MARK: - Private Enums
    enum Constants {
        static let cornerRadius: CGFloat = 23.0
    }

    // MARK: - Private Properties
    private var currentWeatherModel: CityWeatherModel?
    private let viewModel = WeatherDetailsViewModel(persistanceManager: PersistanceManager.shared)

    // MARK: - Setup
    static func instantiate(coordinator: Coordinator?,
                            weatherModel: CityWeatherModel?) -> WeatherDetailsViewController {
        let viewController = StoryboardScene.WeatherDetails.initialScene.instantiate()
        viewController.currentWeatherModel = weatherModel
        viewController.coordinator = coordinator
        viewController.modalPresentationStyle = .overFullScreen

        return viewController
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
}

// MARK: - Actions
private extension WeatherDetailsViewController {
    @IBAction func backgroundButtonTouchedUpInside(_ sender: Any) {
        coordinator?.dismiss()
    }

    @IBAction func closeButtonTouchedUpInside(_ sender: Any) {
        coordinator?.dismiss()
    }

    @IBAction func favoriteButtonTouchedUpInside(_ sender: Any) {
        guard let model = currentWeatherModel else { return }
        viewModel.addOrRemoveCity(with: model) {
            self.updateFavoriteButton()
        }
    }
}

// MARK: - Private Funcs
private extension WeatherDetailsViewController {
    /// Inits the view.
    func initView() {
        detailsView.layer.cornerRadius = Constants.cornerRadius
        titleLabel.text = L10n.weatherDetails
        dailyDetailsView.cityName = currentWeatherModel?.name
        weeklyDetailsView.cityName = currentWeatherModel?.name
        updateFavoriteButton()
    }

    /// Updates favorite button.
    func updateFavoriteButton() {
        if PersistanceManager.shared.isCityRegistered(cityName: currentWeatherModel?.name) {
            favoriteButton.setImage(Asset.icFavoriteOn.image,
                                    for: .normal)
        } else {
            favoriteButton.setImage(Asset.icFavoriteOff.image,
                                    for: .normal)
        }
    }
}
