//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

// MARK: - Protocols
protocol MapCityInfosViewDelegate: AnyObject {
    /// User touches details button.
    ///
    /// - Parameters:
    ///     - weatherModel: the model for weather city displayed
    func didTouchOnDetails(weatherModel: CityWeatherModel)
}

/// Displays informations about a city.
final class MapCityInfosView: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!

    // MARK: - Internal Properties
    weak var delegate: MapCityInfosViewDelegate?

    // MARK: - Private Properties
    private var model: CityWeatherModel?

    // MARK: - Private Enums
    private enum Constants {
        static let radius: CGFloat = 6.0
        static let borderWidth: CGFloat = 2.0
        static let nibName: String = "MapCityInfosView"
    }

    // MARK: - Override Funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInitMapCityInfosView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInitMapCityInfosView()
    }

    // MARK: - Internal Funcs
    /// Fills the view with current city data.
    ///
    /// - Parameters:
    ///     - model: city informations model
    func fill(with model: CityWeatherModel) {
        self.model = model
        weatherImageView.image = UIImage(named: model.imageName)
        tempLabel.text = "\(Int(model.temperature))°"
        cityLabel.text = model.name
    }
}

// MARK: - Actions
private extension MapCityInfosView {
    @IBAction func detailsButtonTouchedUpInside(_ sender: Any) {
        guard let strongModel = model else { return }
        delegate?.didTouchOnDetails(weatherModel: strongModel)
    }
}

// MARK: - Private Funcs
private extension MapCityInfosView {
    /// Common init.
    func commonInitMapCityInfosView() {
        Bundle.main.loadNibNamed(Constants.nibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.cornerRadiusedWith(backgroundColor: .white50,
                                borderColor: .white,
                                radius: Constants.radius,
                                borderWidth: Constants.borderWidth)
    }
}
