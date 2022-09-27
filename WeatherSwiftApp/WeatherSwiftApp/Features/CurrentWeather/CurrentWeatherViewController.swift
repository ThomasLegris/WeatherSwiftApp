//
//  Copyright (C) 2020 Thomas LEGRIS.
//

import UIKit
import WeatherSwiftSDK

/// Screen which shows location weather for a targetted city.
final class CurrentWeatherViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var weatherInfoWidget: WeatherInfoWidget!
    @IBOutlet private weak var nameCityLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var detailsView: UIView!
    @IBOutlet private weak var seeMoreImageView: UIImageView!
    @IBOutlet private weak var timeView: UIView!

    // MARK: - Private Properties
    private var cityName: String? {
        didSet {
            nameCityLabel.text = cityName
        }
    }
    private let viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel(apiManager: WeatherApiManager.shared)
    private weak var coordinator: CurrentWeatherCoordinator?

    // MARK: - Private Enums
    private enum Constants {
        static let cornerRadius: CGFloat = 9.0
        static let borderWidth: CGFloat = 1.0
        static let animationDuration: Double = 0.5
    }

    // MARK: - Setup
    static func instantiate(coordinator: CurrentWeatherCoordinator?) -> CurrentWeatherViewController {
        let viewController = StoryboardScene.CurrentWeather.initialScene.instantiate()
        viewController.coordinator = coordinator

        return viewController
    }

    // MARK: - Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initViewModel()
        requestWeather()
    }
}

// MARK: - Actions
private extension CurrentWeatherViewController {
    @IBAction func searchButtonTouchedUpInside(_ sender: Any) {
        requestWeather()
    }

    @IBAction func refreshButtonTouchedUpInside(_ sender: Any) {
        refreshButton.startRotate(repeatCount: 1.0)
        requestWeather()
    }

    @IBAction func seeMoreButtonTouchedUpInside(_ sender: Any) {
        seeMoreImageView.startRotate(repeatCount: 1.0)
        coordinator?.displayDetails(with: cityName)
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewController {
    /// Inits the view.
    func initView() {
        timeView.isHidden = cityName?.isEmpty != false
        timeLabel.textColor = ColorName.black60.color
        topView.cornerRadiusedWith(backgroundColor: ColorName.white20,
                                   borderColor: ColorName.white80.color,
                                   radius: Constants.cornerRadius,
                                   borderWidth: Constants.borderWidth)

        weatherInfoWidget.cornerRadiusedWith(backgroundColor: ColorName.white20,
                                             borderColor: ColorName.white80.color,
                                             radius: Constants.cornerRadius,
                                             borderWidth: Constants.borderWidth)
        detailsView.roundCorneredWith(backgroundColor: ColorName.white20.color,
                                      borderColor: ColorName.blueDodger50.color,
                                      borderWidth: Constants.borderWidth)

        cityTextField.delegate = self
        let touchGesture = UITapGestureRecognizer(target: self,
                                                  action: #selector(dismissKeyboard))
        view.addGestureRecognizer(touchGesture)
    }

    /// Inits the view model.
    func initViewModel() {
        // Observes weather request error.
        viewModel.weatherErrorObs.bind { [weak self] error in
            guard error != .none else { return }

            self?.updateError(with: error)
        }

        // Observes weather response.
        viewModel.weatherModelObs.bind { [weak self] model in
            self?.updateWidgetModel(with: model)
            self?.updateCityName(with: model.cityName)
        }

        // Observes last updated date in hours.
        viewModel.updatedDateObs.bind { [weak self] date in
            self?.updateDate(with: date)
        }
    }

    /// Update weather last updated date.
    ///
    /// - Parameters:
    ///     - date: string of the last updated date
    func updateDate(with date: String) {
        timeLabel.text = "Last updated weather at \(date)"
    }

    /// Update current city name.
    ///
    /// - Parameters:
    ///     - city: new targetted city
    func updateCityName(with city: String?) {
        timeView.isHidden = city?.isEmpty != false
        guard let city = city else {
            cityName = L10n.errorUnknownLocation
            return
        }

        cityName = city
    }

    /// Update model according to weather request answer.
    ///
    /// - Parameters:
    ///     - model: weather model
    func updateWidgetModel(with model: CommonWeatherModel?) {
        weatherInfoWidget.model = model
    }

    /// Update error during a request.
    ///
    /// - Parameters:
    ///     - error: the weather error
    func updateError(with error: WeatherError) {
        showAlert(withTitle: error.title,
                  message: error.message)
    }

    /// Call view model to perfom request.
    func requestWeather() {
        let city = cityTextField.text?.isEmpty == true
        ? UserDefaults.standard.string(forKey: UserDefaultKeys.lastSearchedCity.rawValue)
        : cityTextField.text
        guard city?.isEmpty == false else { return }

        viewModel.requestWeather(with: city)
    }

    /// Dismiss the keyboard.
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension CurrentWeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
