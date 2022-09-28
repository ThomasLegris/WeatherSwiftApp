//
//  CommonViewControllerDelegate.swift
//  WeatherSwiftApp
//
//  Created by Thomas Legris on 28/09/2022.
//

import Foundation
import WeatherSwiftSDK

// MARK: - Protocols
/// A protocol which can be common for each view controller.
/// Can be inherited if needed.
protocol CommonViewControllerDelegate: AnyObject {
    /// Displays details screen.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    func didClickOnDetails(weatherModel: CityWeatherModel)
}
