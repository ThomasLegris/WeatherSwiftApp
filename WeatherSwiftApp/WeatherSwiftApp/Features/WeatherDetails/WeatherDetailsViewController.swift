//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

protocol WeatherDetailsViewControllerDelegate: AnyObject {
    /// Called when user try to dismiss this screen.
    func didClickOnDismiss()
}

/// Screen which display details about a city weather.
final class WeatherDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var dailyDetailsView: DailyDetailsView!
    @IBOutlet private weak var weeklyDetailsView: WeeklyDetailsView!
    @IBOutlet private weak var detailsView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Internal Properties
    weak var delegate: WeatherDetailsViewControllerDelegate?

    // MARK: - Private Enums
    enum Constants {
        static let cornerRadius: CGFloat = 23.0
    }

    // MARK: - Private Properties
    private var currentWeatherModel: CityWeatherModel?
    private var viewModel: WeatherDetailsViewModel?

    // MARK: - Setup
    static func instantiate(viewModel: WeatherDetailsViewModel,
                            weatherModel: CityWeatherModel?) -> WeatherDetailsViewController {
        let viewController = StoryboardScene.WeatherDetails.initialScene.instantiate()
        viewController.viewModel = viewModel
        viewController.currentWeatherModel = weatherModel
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
        delegate?.didClickOnDismiss()
    }

    @IBAction func closeButtonTouchedUpInside(_ sender: Any) {
        delegate?.didClickOnDismiss()
    }

    @IBAction func favoriteButtonTouchedUpInside(_ sender: Any) {
        guard let model = currentWeatherModel else { return }
        viewModel?.addOrRemoveCity(with: model) {
            self.updateFavoriteButton()
        }
    }
}

// MARK: - Private Funcs
private extension WeatherDetailsViewController {
    func initView() {
        detailsView.layer.cornerRadius = Constants.cornerRadius
        titleLabel.text = L10n.weatherDetails
        dailyDetailsView.cityName = currentWeatherModel?.name
        weeklyDetailsView.cityName = currentWeatherModel?.name
        updateFavoriteButton()
    }

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
