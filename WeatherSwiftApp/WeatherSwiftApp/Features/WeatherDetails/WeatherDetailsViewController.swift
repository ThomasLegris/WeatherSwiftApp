//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import SwiftyUserDefaults
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
    private var cityName: String?

    // MARK: - Setup
    static func instantiate(coordinator: Coordinator?,
                            cityName: String?) -> WeatherDetailsViewController {
        let viewController = StoryboardScene.WeatherDetails.initialScene.instantiate()
        viewController.cityName = cityName
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
        CityDataBaseManager.shared.updateCity(cityName: cityName)
        updateFavoriteButton()
    }
}

// MARK: - Private Funcs
private extension WeatherDetailsViewController {
    /// Inits the view.
    func initView() {
        detailsView.layer.cornerRadius = Constants.cornerRadius
        titleLabel.text =  L10n.weatherDetails
        dailyDetailsView.cityName = cityName
        weeklyDetailsView.cityName = cityName
        updateFavoriteButton()
    }

    /// Updates favorite button.
    func updateFavoriteButton() {
        if CityDataBaseManager.shared.isCityRegistered(cityName: cityName) {
            favoriteButton.setImage(Asset.icFavoriteOn.image,
                                    for: .normal)
        } else {
            favoriteButton.setImage(Asset.icFavoriteOff.image,
                                    for: .normal)
        }
    }
}
