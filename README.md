# WeatherSwiftApp
iOS App which returns several infos about city weather

## Architecture:
- Multimodule app
- Separated into a SDK framework & App framework.
- MVVM pattern with navigation managed by Coordinator Protocol
- No external dependencies except Swiftlint & Swiftgen for code quality

## Features:
- Current weather with search bar to choose city by its name
- Daily and weekly details for the city selected
- Favorite cities list to store city registered by user
- Map view to find weather with location (lat & long) 

<img width="627" alt="Capture d’écran 2022-09-23 à 15 46 15" src="https://user-images.githubusercontent.com/34026747/192211666-4365725c-86fb-4d07-a73f-1337462b51d6.png">

## Notes:
- This app is based on another personal app which can be found here https://github.com/ThomasLegris/weatherApp 
- A sample one has been created for a new developer TP on my previous company. Several steps starting from the sample (only 1 screen in MVC architecture)
https://github.com/ThomasLegris/SampleSwiftWeather
- A SwiftUI/Combine one has been created too. https://github.com/ThomasLegris/SwiftUIWeather
