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
    func testRegisterNilCityName() throws {
        // Given
        let cityName: String? = nil

        // When
        manager.updateCity(cityName: cityName) { isSuccess in
            // Then
            XCTAssertEqual(isSuccess, false)
        }
    }

    func testRegisterEmptyCityName() throws {
        // Given
        let cityName: String? = ""

        // When
        manager.updateCity(cityName: cityName) { isSuccess in
            // Then
            XCTAssertEqual(isSuccess, false)
        }
    }

    func testRegisterValidCityName() throws {
        // Given
        let cityName: String? = "London"

        // When
        manager.updateCity(cityName: cityName) { isSuccess in
            // Then
            XCTAssertEqual(isSuccess, true)
        }
    }
}

// MARK: - Remove City
extension PersistanceRegisterCityTests {
    func testRemoveValidCityName() throws {
        // Given
        let cityName: String? = "Paris"

        // When
        manager.updateCity(cityName: cityName, completion: { registerSucceed in
            if registerSucceed {
                manager.updateCity(cityName: cityName) { removeSucceed in
                    // Then
                    XCTAssertEqual(removeSucceed, true)
                }
            }
        })
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
