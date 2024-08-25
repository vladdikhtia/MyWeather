//
//  CityModel.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 23/08/2024.
//

import Foundation
import SwiftData

@Model
class CityModel: Identifiable, Hashable {
    let id = UUID().uuidString
    let name: String
    let longitude: Double
    let latitude: Double
    let dateAdded: Date

    init(name: String, longitude: Double, latitude: Double, dateAdded: Date = Date()) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.dateAdded = dateAdded
    }
}
