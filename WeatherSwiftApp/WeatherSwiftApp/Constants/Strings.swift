// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Error
  internal static let commonError = L10n.tr("Localizable", "commonError", fallback: "Error")
  /// Ok
  internal static let commonOk = L10n.tr("Localizable", "commonOk", fallback: "Ok")
  /// Warning
  internal static let commonWarning = L10n.tr("Localizable", "commonWarning", fallback: "Warning")
  /// Daily
  internal static let dailyDetails = L10n.tr("Localizable", "dailyDetails", fallback: "Daily")
  /// *
  ///  * Localization.
  internal static let dash = L10n.tr("Localizable", "dash", fallback: "-")
  /// Can't update weather info
  internal static let errorNoInfo = L10n.tr("Localizable", "errorNoInfo", fallback: "Can't update weather info")
  /// No Internet connection
  internal static let errorNoInternet = L10n.tr("Localizable", "errorNoInternet", fallback: "No Internet connection")
  /// Internet connection is needed for weather details
  internal static let errorNoInternetDetails = L10n.tr("Localizable", "errorNoInternetDetails", fallback: "Internet connection is needed for weather details")
  /// Unknown city
  internal static let errorUnknownCity = L10n.tr("Localizable", "errorUnknownCity", fallback: "Unknown city")
  /// Unknown location
  internal static let errorUnknownLocation = L10n.tr("Localizable", "errorUnknownLocation", fallback: "Unknown location")
  /// Favorite cities
  internal static let favoriteList = L10n.tr("Localizable", "favoriteList", fallback: "Favorite cities")
  /// Home
  internal static let home = L10n.tr("Localizable", "home", fallback: "Home")
  /// Humidity
  internal static let humidity = L10n.tr("Localizable", "humidity", fallback: "Humidity")
  /// Can't find user location
  internal static let locationErrorMessage = L10n.tr("Localizable", "locationErrorMessage", fallback: "Can't find user location")
  /// Location Error
  internal static let locationErrorTitle = L10n.tr("Localizable", "locationErrorTitle", fallback: "Location Error")
  /// Map
  internal static let map = L10n.tr("Localizable", "map", fallback: "Map")
  /// %%
  internal static let percentUnit = L10n.tr("Localizable", "percentUnit", fallback: "%%")
  /// km/h
  internal static let speedUnit = L10n.tr("Localizable", "speedUnit", fallback: "km/h")
  /// Sunrise
  internal static let sunrise = L10n.tr("Localizable", "sunrise", fallback: "Sunrise")
  /// Sunset
  internal static let sunset = L10n.tr("Localizable", "sunset", fallback: "Sunset")
  /// Weather details
  internal static let weatherDetails = L10n.tr("Localizable", "weatherDetails", fallback: "Weather details")
  /// Weekly
  internal static let weeklyDetails = L10n.tr("Localizable", "weeklyDetails", fallback: "Weekly")
  /// Wind
  internal static let wind = L10n.tr("Localizable", "wind", fallback: "Wind")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
