//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import MapKit
import Reusable

// MARK: - Protocols
protocol MapAnnotationDelegate: AnyObject {
    // MARK: - Internal Funcs
    /// Called when there are infos about current coordinate weather.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    ///     - weatherIcon: icon which describes weather
    ///     - temperature: current temperature value
    func shouldShowWeatherCityInfos(cityName: String,
                                    weatherIcon: UIImage,
                                    temperature: String)
}

/// Custom annotation object for map.
class MapAnnotation: NSObject, MKAnnotation {
    // MARK: - Internal Properties
    var coordinate: CLLocationCoordinate2D

    // MARK: - Override Funcs
    override init() {
        self.coordinate = CLLocationCoordinate2D()
    }
}

/// Shows a custom annotation view.
final class MapAnnotationView: MKAnnotationView, NibOwnerLoadable {
    // MARK: - Outlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Internal Properties
    weak var delegate: MapAnnotationDelegate?

    // MARK: - Private Properties
    private let viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()

    // MARK: - Override Funcs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        self.commonInit()
    }
}

// MARK: - Private Funcs
private extension MapAnnotationView {
    /// Common init.
    func commonInit() {
        loadNibContent()
        viewModel.requestWeather(with: annotation?.coordinate)
        viewModel.weatherModelObs.bind { [weak self] model in
            self?.updateView(with: model)
        }
    }

    /// Updates the view.
    ///
    /// - Parameters:
    ///     - model: common weather model
    func updateView(with model: CommonWeatherModel) {
        guard let temp = model.temperature,
              let icon = model.icon,
              let name = model.cityName else {
            return
        }

        iconImageView.image = icon
        tempLabel.text = "\(Int(temp))°"
        delegate?.shouldShowWeatherCityInfos(cityName: name,
                                             weatherIcon: icon,
                                             temperature: "\(Int(temp))°")
    }
}
