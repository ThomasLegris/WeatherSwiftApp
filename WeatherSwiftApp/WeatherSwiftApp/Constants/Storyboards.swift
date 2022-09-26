// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length implicit_return

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length prefer_self_in_static_references
// swiftlint:disable type_body_length type_name
internal enum StoryboardScene {
  internal enum CurrentWeather: StoryboardType {
    internal static let storyboardName = "CurrentWeather"

    internal static let initialScene = InitialSceneType<CurrentWeatherViewController>(storyboard: CurrentWeather.self)

    internal static let myCurrentWeatherViewController = SceneType<CurrentWeatherViewController>(storyboard: CurrentWeather.self, identifier: "MyCurrentWeatherViewController")
  }
  internal enum FavoritesCitiesList: StoryboardType {
    internal static let storyboardName = "FavoritesCitiesList"

    internal static let initialScene = InitialSceneType<FavoriteCitiesListViewController>(storyboard: FavoritesCitiesList.self)

    internal static let favoritesListViewController = SceneType<FavoriteCitiesListViewController>(storyboard: FavoritesCitiesList.self, identifier: "FavoritesListViewController")
  }
  internal enum Home: StoryboardType {
    internal static let storyboardName = "Home"

    internal static let initialScene = InitialSceneType<HomeViewController>(storyboard: Home.self)
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum WeatherDetails: StoryboardType {
    internal static let storyboardName = "WeatherDetails"

    internal static let initialScene = InitialSceneType<WeatherDetailsViewController>(storyboard: WeatherDetails.self)

    internal static let weatherDetails = SceneType<WeatherDetailsViewController>(storyboard: WeatherDetails.self, identifier: "WeatherDetails")
  }
  internal enum WeatherMap: StoryboardType {
    internal static let storyboardName = "WeatherMap"

    internal static let initialScene = InitialSceneType<WeatherMapViewController>(storyboard: WeatherMap.self)

    internal static let weatherMapViewController = SceneType<WeatherMapViewController>(storyboard: WeatherMap.self, identifier: "WeatherMapViewController")
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length prefer_self_in_static_references
// swiftlint:enable type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
  internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
      fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
    }
    return controller
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
