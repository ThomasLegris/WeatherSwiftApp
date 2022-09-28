//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// View which displays a resume of the weather.e
final class WeatherInfoWidget: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!

    // MARK: - Internal Properties
    /// Returns a common model for city weather.
    var model: CityWeatherModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Private Enums
    private enum Constants {
        static let format: String = "dd.MM.yyyy"
        static let nibName: String = "WeatherInfoWidget"
    }

    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitWeatherInfoWidget()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitWeatherInfoWidget()
    }
}

// MARK: - Private Funcs
private extension WeatherInfoWidget {
    /// Common init.
    func commonInitWeatherInfoWidget() {
        Bundle.main.loadNibNamed(Constants.nibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        temperatureLabel.textColor = ColorName.black60.color
        descriptionLabel.textColor = ColorName.black60.color

        dateLabel.textColor = ColorName.black60.color
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.format
        dateLabel.text = formatter.string(from: Date())
    }

    /// Updates the view.
    func updateView() {
        guard let model = model else {
            resetView()
            return
        }

        temperatureLabel.text = model.temperature.tempDesccription
        descriptionLabel.text = model.weatherDescription
        weatherImageView.image = UIImage(named: model.imageName)
    }

    /// Resets the view.
    func resetView() {
        temperatureLabel.text = L10n.dash
        descriptionLabel.text = L10n.dash
        weatherImageView.image = nil
    }
}
