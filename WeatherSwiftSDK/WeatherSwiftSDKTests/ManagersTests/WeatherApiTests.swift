//
//  WeatherApiTests.swift
//  WeatherSwiftSDKTests
//
//  Created by Thomas Legris on 27/09/2022.
//

import XCTest
import WeatherSwiftSDK

final class WeatherApiTests: XCTestCase {
    // MARK: - Private Properties
    private let manager: ApiManagerProtocol = WeatherApiManager.shared

    // MARK: - Override Funcs
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Name weather request
extension WeatherApiTests {
    /// Requests weather with empty city.
    func testRequestEmptyCityName() {
        // GIVEN
        let cityName: String = ""

        // WHEN
        manager.cityWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }

    /// Requests weather with unknown city name.
    func testRequestInvalidCityName() {
        // GIVEN
        let cityName: String = "WeatherSwiftApp"

        // WHEN
        manager.cityWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }
}

// MARK: - Location weather request
extension WeatherApiTests {
    /// Requests weather with invalid lat and long city.
    func testRequestInvalidLocation() {
        // FIXME: Won't work due to API key not found
        // GIVEN
        let lat: Double = -91
        let long: Double = -181

        // WHEN
        manager.locationWeather(latitude: lat,
                                longitude: long) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }
}

// MARK: - Daily Details request
extension WeatherApiTests {
    /// Requests weather with empty city.
    func testRequestDailyDetailsEmptyName() {
        // GIVEN
        let cityName: String = ""

        // WHEN
        manager.cityDetailsWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }

    /// Requests weather with unknown city.
    func testRequestDailyDetailsInvalidName() {
        // FIXME: Won't work due to API key not found

        // GIVEN
        let cityName: String = "WeatherSwiftApp"
        // WHEN
        manager.cityDetailsWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }

    /// Requests weather with a known city.
    func testRequestDailyDetailsValidName() {
        // FIXME: Won't work due to API key not found

        // GIVEN
        let cityName: String = "London"
        // WHEN
        manager.cityWeeklyWeather(cityName: cityName) { response, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }
}

// MARK: - Weekly Details request
extension WeatherApiTests {
    /// Requests weather with empty city.
    func testRequestWeeklyDetailsEmptyName() {
        // GIVEN
        let cityName: String = ""

        // WHEN
        manager.cityWeeklyWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }

    /// Requests weather with unknown city.
    func testRequestWeeklyDetailsInvalidName() {
        // FIXME: Won't work due to API key not found

        // GIVEN
        let cityName: String = "WeatherSwiftApp"
        // WHEN
        manager.cityWeeklyWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }
a
    /// Requests weather with a know city.
    func testRequestWeeklyDetailsValidName() {
        // FIXME: Won't work due to API key not found

        // GIVEN
        let cityName: String = "Paris"
        // WHEN
        manager.cityWeeklyWeather(cityName: cityName) { response, error in
            // THEN
            print("test error \(error)")
            XCTAssertNotNil(error)

        }
    }
}
