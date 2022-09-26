// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let icCurrentWeatherItemOff = ImageAsset(name: "icCurrentWeatherItemOff")
  internal static let icCurrentWeatherItemOn = ImageAsset(name: "icCurrentWeatherItemOn")
  internal static let icFavItemOff = ImageAsset(name: "icFavItemOff")
  internal static let icFavItemOn = ImageAsset(name: "icFavItemOn")
  internal static let icMapItemOff = ImageAsset(name: "icMapItemOff")
  internal static let icMapItemOn = ImageAsset(name: "icMapItemOn")
  internal static let bgDay = ImageAsset(name: "bgDay")
  internal static let bgList = ImageAsset(name: "bgList")
  internal static let icApp = ImageAsset(name: "icApp")
  internal static let icClose = ImageAsset(name: "icClose")
  internal static let icLocation = ImageAsset(name: "icLocation")
  internal static let icMenu = ImageAsset(name: "icMenu")
  internal static let icNext = ImageAsset(name: "icNext")
  internal static let icSeeMore = ImageAsset(name: "icSeeMore")
  internal static let icDay = ImageAsset(name: "icDay")
  internal static let icFavoriteOff = ImageAsset(name: "icFavoriteOff")
  internal static let icFavoriteOn = ImageAsset(name: "icFavoriteOn")
  internal static let icHumidity = ImageAsset(name: "icHumidity")
  internal static let icNight = ImageAsset(name: "icNight")
  internal static let icWind = ImageAsset(name: "icWind")
  internal static let _01d = ImageAsset(name: "01d")
  internal static let _01n = ImageAsset(name: "01n")
  internal static let _02d = ImageAsset(name: "02d")
  internal static let _02n = ImageAsset(name: "02n")
  internal static let _03d = ImageAsset(name: "03d")
  internal static let _03n = ImageAsset(name: "03n")
  internal static let _04d = ImageAsset(name: "04d")
  internal static let _04n = ImageAsset(name: "04n")
  internal static let _09d = ImageAsset(name: "09d")
  internal static let _09n = ImageAsset(name: "09n")
  internal static let _10d = ImageAsset(name: "10d")
  internal static let _10n = ImageAsset(name: "10n")
  internal static let _11d = ImageAsset(name: "11d")
  internal static let _11n = ImageAsset(name: "11n")
  internal static let _13d = ImageAsset(name: "13d")
  internal static let _13n = ImageAsset(name: "13n")
  internal static let _50d = ImageAsset(name: "50d")
  internal static let _50n = ImageAsset(name: "50n")
  internal static let icFog = ImageAsset(name: "icFog")
  internal static let icMainBackground = ImageAsset(name: "icMainBackground")
  internal static let icRain = ImageAsset(name: "icRain")
  internal static let icRefresh = ImageAsset(name: "icRefresh")
  internal static let icSearch = ImageAsset(name: "icSearch")
  internal static let icSnow = ImageAsset(name: "icSnow")
  internal static let icSun = ImageAsset(name: "icSun")
  internal static let icSunCloudy = ImageAsset(name: "icSunCloudy")
  internal static let icThermometer = ImageAsset(name: "icThermometer")
  internal static let icThunder = ImageAsset(name: "icThunder")
  internal static let icMapDetails = ImageAsset(name: "icMapDetails")
  internal static let icMapPointer = ImageAsset(name: "icMapPointer")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
