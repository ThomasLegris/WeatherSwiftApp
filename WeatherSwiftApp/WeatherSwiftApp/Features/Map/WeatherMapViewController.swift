//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import MapKit
import WeatherSwiftSDK

/// Pick weather details on Map.
final class WeatherMapViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var mapCityInfosView: MapCityInfosView!

    // MARK: - Internal Properties
    weak var delegate: CommonViewControllerDelegate?

    // MARK: - Private Properties
    private let locationManager = CLLocationManager()

    // MARK: - Private Enums
    private enum Constants {
        static let identifier: String = "MapAnnotationView"
    }

    // MARK: - Setup
    static func instantiate() -> WeatherMapViewController {
        let viewController = StoryboardScene.WeatherMap.initialScene.instantiate()

        return viewController
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        requestLocationAccess()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mapView.removeAnnotations(mapView.annotations)
        mapCityInfosView.isHidden = true
    }
}

// MARK: - Actions
private extension WeatherMapViewController {
    @IBAction func locationButtonTouchedUpInside(_ sender: Any) {
        guard let coordinate = mapView.userLocation.location?.coordinate else {
            self.showAlert(withTitle: L10n.locationErrorTitle,
                           message: L10n.locationErrorMessage)
            return
        }

        mapView.setCenter(coordinate, animated: true)
    }

    @objc func onMapTouchedUpInside(recognizer: UITapGestureRecognizer) {
        addAnnotation(at: mapView.convert(recognizer.location(in: mapView),
                                          toCoordinateFrom: mapView))
    }
}

// MARK: - Private Funcs
private extension WeatherMapViewController {
    func initView() {
        mapView.register(MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constants.identifier)
        locationButton.roundCorneredWith(backgroundColor: ColorName.black20.color,
                                         borderColor: ColorName.black60.color,
                                         borderWidth: 1.0)
        mapView.delegate = self
        mapView?.showsUserLocation = true

        let singleTapRecognizer = UITapGestureRecognizer(target: self,
                                                         action: #selector(onMapTouchedUpInside(recognizer:)))
        mapView.addGestureRecognizer(singleTapRecognizer)
    }

    /// Add a custom annotation graphic.
    ///
    /// - Parameters:
    ///     - coordinate: location coordinate
    func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MapAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print(L10n.errorUnknownLocation)
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    /// Shows map info view with a fade animation.
    func addWithAnimation() {
        self.mapCityInfosView.alpha = 0.0
        self.mapCityInfosView.isHidden = false
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.mapCityInfosView.alpha = 1.0
        })
    }
}

// MARK: - MKMapViewDelegate
extension WeatherMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation = MapAnnotationView(annotation: annotation,
                                           reuseIdentifier: Constants.identifier)
        annotation.delegate = self
        return annotation
    }
}

// MARK: - MapAnnotationDelegate
extension WeatherMapViewController: MapAnnotationDelegate {
    func shouldShowWeatherCityInfos(cityName: String, weatherIconName: String, temperature: Float) {
        mapCityInfosView.fill(with: CityWeatherModel(name: cityName,
                                                     imageName: weatherIconName,
                                                     weatherDescription: "",
                                                     temperature: temperature))
        mapCityInfosView.delegate = self
        addWithAnimation()
    }
}

// MARK: - MapCityInfosViewDelegate
extension WeatherMapViewController: MapCityInfosViewDelegate {
    func didTouchOnDetails(weatherModel: CityWeatherModel) {
        delegate?.didClickOnDetails(weatherModel: weatherModel)
    }
}
