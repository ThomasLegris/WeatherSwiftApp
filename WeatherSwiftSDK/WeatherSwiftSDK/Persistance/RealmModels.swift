//
//  RealmModels.swift
//  WeatherSwiftSDK
//
//  Created by Consultant on 23/09/2022.
//
//

import RealmSwift
import Foundation

/// Stores a Favorite city object for data base.
public class FavoriteCity: Object {
    /// Name of the city to add in favorite table.
    @objc dynamic public var cityName: String = ""

    public override init() { }
}
