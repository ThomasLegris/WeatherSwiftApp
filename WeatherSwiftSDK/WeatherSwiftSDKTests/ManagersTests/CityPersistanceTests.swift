//
//  PersistanceManagerTest.swift
//  WeatherSwiftSDKTests
//
//  Created by Thomas Legris on 27/09/2022.
//

import XCTest
import WeatherSwiftSDK

/// Unit tests for persistance manager.
final class PersistanceRegisterCityTests: XCTestCase {
    // MARK: - Private Properties
    private let manager: PersistanceManagerProtocol = PersistanceManager.shared

    // MARK: - Override Funcs
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Register City
extension PersistanceRegisterCityTests {
    func testRegisterEmptyCityName() throws {
        // Given
        let city = CityWeatherModel(name: "", imageName: "", weatherDescription: "", temperature: 0)

        // When
        manager.addOrRemoveCity(city: city) { isSuccess in
            // Then
            XCTAssertEqual(isSuccess, false)
        }
    }

    func testRegisterValidCityName() throws {
        // Given
        let city = CityWeatherModel(name: "London", imageName: "", weatherDescription: "Clouds", temperature: 10.0)

        // When
        manager.addOrRemoveCity(city: city) { isSuccess in
            // Then
            XCTAssertEqual(isSuccess, true)
        }
    }
}

// MARK: - Remove City
extension PersistanceRegisterCityTests {
    func testRemoveValidCityName() throws {
        // Given
        let city = CityWeatherModel(name: "Paris", imageName: "", weatherDescription: "Sunny", temperature: 14.0)

        // When
        manager.addOrRemoveCity(city: city) { registerSucceed in
            if registerSucceed {
                manager.addOrRemoveCity(city: city) { removeSucceed in
                    // Then
                    XCTAssertEqual(removeSucceed, true)
                }
            }
        }
    }
}

// MARK: - Check Register
extension PersistanceRegisterCityTests {
    func testCheckRegisterNilCityName() throws {
        // Given
        let cityName: String? = nil

        // When
        let isRegistered = manager.isCityRegistered(cityName: cityName)

        // Then
        XCTAssertEqual(isRegistered, false)

    }

    func testCheckRegisterEmptyCityName() throws {
        // Given
        let cityName: String? = ""

        // When
        let isRegistered = manager.isCityRegistered(cityName: cityName)

        // Then
        XCTAssertEqual(isRegistered, false)
    }
}
