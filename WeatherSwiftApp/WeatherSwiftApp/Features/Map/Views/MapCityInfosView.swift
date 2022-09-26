//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import Reusable

// MARK: - Protocols
protocol MapCityInfosViewDelegate: AnyObject {
    /// User touches details button.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    func didTouchOnDetails(cityName: String)
}

// MARK: - Structs
struct MapCityInfos {
    var cityName: String = L10n.dash
    var weatherIcon: UIImage = Asset.icSun.image
    var temperature: String = "0°"
}

/// Displays informations about a city.
final class MapCityInfosView: UIView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!

    // MARK: - Internal Properties
    var model: MapCityInfos = MapCityInfos() {
        didSet {
            fill(with: model)
        }
    }
    weak var delegate: MapCityInfosViewDelegate?

    // MARK: - Private Enums
    private enum Constants {
        static let radius: CGFloat = 6.0
        static let borderWidth: CGFloat = 2.0
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
}

// MARK: - Actions
private extension MapCityInfosView {
    @IBAction func detailsButtonTouchedUpInside(_ sender: Any) {
        delegate?.didTouchOnDetails(cityName: model.cityName)
    }
}

// MARK: - Private Funcs
private extension MapCityInfosView {
    /// Common init.
    func commonInitMapCityInfosView() {
        self.loadNibContent()

        self.cornerRadiusedWith(backgroundColor: .white50,
                                borderColor: .white,
                                radius: Constants.radius,
                                borderWidth: Constants.borderWidth)
    }

    /// Fills the view with current city data.
    ///
    /// - Parameters:
    ///     - model: city informations model
    func fill(with model: MapCityInfos) {
        weatherImageView.image = model.weatherIcon
        tempLabel.text = model.temperature
        cityLabel.text = model.cityName
    }
}
