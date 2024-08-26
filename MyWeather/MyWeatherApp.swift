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
    let container: ModelContainer
    let networkManager: NetworkManager
    let storageManager: StorageManager
    

    var body: some Scene {
        WindowGroup {
            HomeCitiesView(networkManager: networkManager, storageManager: storageManager)
                .modelContainer(container)

        }
    }
    init() {
            do {
                container = try ModelContainer(for: CityModel.self)
                networkManager = NetworkManager()
                storageManager = StorageManager(modelContext: container.mainContext)
            } catch {
                fatalError("Failed to create ModelContainer for CityModel. \(error.localizedDescription)")
            }
        }
}
