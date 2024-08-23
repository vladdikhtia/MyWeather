//
//  MyWeatherApp.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import SwiftUI
import SwiftData

@main
struct MyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeCitiesView()
                .modelContainer(for: CityModel.self)
        }
    }
}
