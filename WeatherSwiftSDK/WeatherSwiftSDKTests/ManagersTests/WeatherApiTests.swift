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
    /// Requests weather with nil city.
    func testRequestEmptyCityName() {
        // GIVEN
        let cityName: String = ""

        // FIXME: No No API plist file error. See persistance manager about bundle research.
        // WHEN
        manager.cityWeather(cityName: cityName) { _, error in
            // THEN
            XCTAssertNotNil(error)
        }
    }
}
