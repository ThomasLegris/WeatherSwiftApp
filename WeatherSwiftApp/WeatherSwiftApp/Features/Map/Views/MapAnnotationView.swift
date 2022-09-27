//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import MapKit
import WeatherSwiftSDK

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
                                    weatherIconName: String,
                                    temperature: Float)
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
final class MapAnnotationView: MKAnnotationView {
    // MARK: - Outlets
    @IBOutlet private var contentView: MKAnnotationView!
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!

    // MARK: - Internal Properties
    weak var delegate: MapAnnotationDelegate?

    // MARK: - Private Properties
    private let viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel(apiManager: WeatherApiManager.shared,
                                                                             persistanceManager: PersistanceManager.shared)
    // TODO: Create a specific viewModel

    // MARK: - Private Enums
    private enum Constants {
        static let nibName: String = "MapAnnotationView"
    }

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
        Bundle.main.loadNibNamed(Constants.nibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewModel.requestWeather(with: annotation?.coordinate)
        viewModel.weatherModelObs.bind { [weak self] model in
            self?.updateView(with: model)
        }
    }

    /// Updates the view.
    ///
    /// - Parameters:
    ///     - model: common weather model
    func updateView(with model: CityWeatherModel) {
        iconImageView.image = UIImage(named: model.imageName)
        tempLabel.text = "\(Int(model.temperature))°"
        delegate?.shouldShowWeatherCityInfos(cityName: model.name,
                                             weatherIconName: model.imageName,
                                             temperature: model.temperature)
    }
}
