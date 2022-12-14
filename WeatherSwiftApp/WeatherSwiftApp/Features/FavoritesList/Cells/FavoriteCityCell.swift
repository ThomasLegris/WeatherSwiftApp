//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Displays a city weather cell in the favorite cities table view.
final class FavoriteCityCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionIcon: UIImageView!
    @IBOutlet private weak var bgView: UIView!

    // MARK: - Private Properties
    private var cityModel: CityWeatherModel?
    private let viewModel: FavoriteCityCellViewModel = FavoriteCityCellViewModel(apiManager: WeatherApiManager.shared,
                                                                                 persistanceManager: PersistanceManager.shared)

    // MARK: - Private Enums
    private enum Constants {
        static let cornerRadius: CGFloat = 6.0
        static let borderWidth: CGFloat = 1.0
    }

    // MARK: - Override Funcs
    override func awakeFromNib() {
        super.awakeFromNib()

        initView()
    }

    // MARK: - Internal Funcs
    /// Configures the cell.
    ///
    /// - Parameters:
    ///     - city: current city registered in favorite
    func configureCell(cityModel: CityWeatherModel) {
        self.cityModel = cityModel
        viewModel.defaultCityModel = cityModel
        setupViewModel()
    }
}

// MARK: - Private Funcs
private extension FavoriteCityCell {
    func initView() {
        resetView()
        bgView.cornerRadiusedWith(backgroundColor: ColorName.white20,
                                  borderColor: ColorName.white50.color,
                                  radius: Constants.cornerRadius,
                                  borderWidth: Constants.borderWidth)
    }

    func setupViewModel() {
        viewModel.requestWeather(with: cityModel?.name)
        viewModel.weatherModelObs.bind { [weak self] _ in
            self?.updateView()
        }
        updateView()
    }

    func resetView() {
        temperatureLabel.text = L10n.dash
        cityLabel.text = L10n.dash
        weatherDescriptionLabel.text = L10n.dash
        weatherDescriptionIcon.image = nil
    }

    /// Update view according to weather request answer.
    func updateView() {
        let model = viewModel.weatherModelObs.value
        temperatureLabel.text = model.temperature.tempDesccription
        cityLabel.text = model.name
        weatherDescriptionLabel.text = model.weatherDescription
        weatherDescriptionIcon.image = UIImage(named: model.imageName)
    }
}
