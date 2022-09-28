# WeatherSwiftApp
Welcome to this repo. 

It contains a Swift iOS application which provides several information about city weather.

## Features:
- Current weather with search bar to choose city by its name
- Favorite cities list to store towns registered by user
- Map view to find weather with location (lat & long) 
- Daily and weekly details for the town selected (available from each screen)
- Offline mode. Without connection, user has still several weather data about last city searched and favorite cities registered
- SDK's unit tests
- SDK's docs (using https://app.diagrams.net)

## Architecture:
- Multimodule app
- Separated into a SDK framework & App framework
- MVVM pattern
- Navigation managed with Coordinator Protocol
- TabBarViewController used to display the 3 main screens
- No external dependencies except Swiftlint & Swiftgen for code quality

## Main technical information:
- App preferences: `UserDefaults`
- Persistance: `CoreData`
- API call: `URLSession`
- DataBinding: Custom `Observable` object
- Navigation: `Coordinator` pattern
- Code quality: `Swiftlint`
- Unit test: `XCTestCase` (Only on SwiftWeatherSDK Target)
- Managers: DIP and Singletons mix. A good practice would be to use only DIP (for example, we could try https://github.com/Swinject/Swinject)


## UI:
<img width="627" alt="Capture d’écran 2022-09-23 à 15 46 15" src="https://user-images.githubusercontent.com/34026747/192211666-4365725c-86fb-4d07-a73f-1337462b51d6.png">

## Notes:
- This app is based on another personal app which can be found here https://github.com/ThomasLegris/weatherApp 
- In my previous company, I created a sample MVC one. The goal was to introduce `Swift` frameworks and pattern to new company developers 
https://github.com/ThomasLegris/SampleSwiftWeather
- To discover new frameworks, A SwiftUI/Combine one has been created too https://github.com/ThomasLegris/SwiftUIWeather
- Assets source: https://www.flaticon.com
