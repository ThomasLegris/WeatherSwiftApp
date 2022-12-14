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

    // MARK: - Internal Properties
    weak var delegate: CommonViewControllerDelegate?

    // MARK: - Private Properties
    private var cityName: String? {
        didSet {
            nameCityLabel.text = cityName
        }
    }
    private var viewModel: CurrentWeatherViewModel?

    // MARK: - Private Enums
    private enum Constants {
        static let cornerRadius: CGFloat = 9.0
        static let borderWidth: CGFloat = 1.0
        static let animationDuration: Double = 0.5
    }

    // MARK: - Setup
    static func instantiate(viewModel: CurrentWeatherViewModel) -> CurrentWeatherViewController {
        let viewController = StoryboardScene.CurrentWeather.initialScene.instantiate()
        viewController.viewModel = viewModel

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
        if viewModel?.isNetworkReachable == false {
            self.showAlert(withTitle: L10n.commonError,
                      message: L10n.errorNoInternetDetails)
        } else if let model = viewModel?.weatherModelObs.value,
                  model.name.isValidCityName {
            delegate?.didClickOnDetails(weatherModel: model)
        } else {
            self.showAlert(withTitle: L10n.commonError,
                      message: L10n.errorNoCityDetails)

        }
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewController {
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

    func initViewModel() {
        // Observes weather request error.
        viewModel?.weatherErrorObs.bind { [weak self] error in
            guard error != .none else { return }

            self?.updateError(with: error)
        }

        // Observes weather response.
        viewModel?.weatherModelObs.bind { [weak self] model in
            self?.updateWidgetModel(with: model)
            self?.updateCityName(with: model.name)
        }

        // Observes last updated date in hours.
        viewModel?.updatedDateObs.bind { [weak self] date in
            self?.updateDate(with: date)
        }
    }

    /// Update weather last updated date.
    ///
    /// - Parameters:
    ///     - date: string of the last updated date
    func updateDate(with date: String) {
        timeView.isHidden = date.isEmpty
        timeLabel.text = "Last updated weather at \(date)"
    }

    /// Update current city name with api callback.
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
    func updateWidgetModel(with model: CityWeatherModel?) {
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
        ? viewModel?.defaultCity?.name ?? ""
        : cityTextField.text

        // Don't call API if there is no city written in textfield and never setted in default.
        if city?.isNotEmpty == true {
            viewModel?.requestWeather(with: city)
        } else if UserDefaults.standard.integer(forKey: UserDefaultKeys.appLaunchCount.rawValue) < 2 {
            // Show a welcome message at first launch.
            self.showAlert(withTitle: L10n.commonWelcome,
                           message: L10n.alertWelcomeMessage)
        }
    }

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
