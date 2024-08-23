//
//  CityModel.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 23/08/2024.
//

import Foundation
import SwiftData

@Model
class CityModel {
    var name: String
    var longitude: Double
    var latitude: Double

    init(name: String, longitude: Double, latitude: Double) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
}
