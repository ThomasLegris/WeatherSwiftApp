//
//  Copyright (C) 2021 Thomas LEGRIS.
//

import UIKit
import MapKit

/// Pick weather details on Map.
final class WeatherMapViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationButton: UIButton!
    @IBOutlet private weak var detailsCityContainerView: MapCityInfosView!

    // MARK: - Internal Properties
    weak var coordinator: MapCoodinator?

    // MARK: - Private Properties
    private let locationManager = CLLocationManager()

    // MARK: - Private Enums
    private enum Constants {
        static let identifier: String = "MapAnnotationView"
    }

    // MARK: - Setup
    static func instantiate(coordinator: MapCoodinator?) -> WeatherMapViewController {
        let viewController = StoryboardScene.WeatherMap.initialScene.instantiate()
        viewController.coordinator = coordinator

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
        detailsCityContainerView.isHidden = true
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
    /// Inits the view.
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

    /// Requests location access.
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

    /// Shows map info view.
    func addWithAnimation() {
        self.detailsCityContainerView.alpha = 0.0
        self.detailsCityContainerView.isHidden = false
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.detailsCityContainerView.alpha = 1.0
        })
    }
}

// MARK: - MKMapViewDelegate
extension WeatherMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotation =  MapAnnotationView(annotation: annotation,
                                            reuseIdentifier: Constants.identifier)
        annotation.delegate = self
        return annotation
    }
}

// MARK: - MapAnnotationDelegate
extension WeatherMapViewController: MapAnnotationDelegate {
    func shouldShowWeatherCityInfos(cityName: String, weatherIcon: UIImage, temperature: String) {
        detailsCityContainerView.model = MapCityInfos(cityName: cityName,
                                                      weatherIcon: weatherIcon,
                                                      temperature: temperature)
        detailsCityContainerView.delegate = self
        addWithAnimation()
    }
}

// MARK: - MapCityInfosViewDelegate
extension WeatherMapViewController: MapCityInfosViewDelegate {
    func didTouchOnDetails(cityName: String) {
        coordinator?.displayDetails(with: cityName)
    }
}
