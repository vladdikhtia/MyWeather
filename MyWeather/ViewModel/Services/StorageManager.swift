//
//  StorageServiceManager.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 25/08/2024.
//

import Foundation
import SwiftData

protocol StorageProtocol {
    func addCity(name: String, longitude: Double, latitude: Double)
    func deleteCity(at indexSet: IndexSet)
    func fetchCitiesFromDB() -> [CityModel]
}

class StorageManager: StorageProtocol {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addCity(name: String, longitude: Double, latitude: Double) {
        let city = CityModel(name: name, longitude: longitude, latitude: latitude)
        modelContext.insert(city)
    }
    
    func deleteCity(at indexSet: IndexSet) {
        for index in indexSet {
            let city = fetchCitiesFromDB()[index]
            modelContext.delete(city)
        }
    }
    
    func fetchCitiesFromDB() -> [CityModel] {
        do {
            let descriptor = FetchDescriptor<CityModel>(sortBy: [SortDescriptor(\.dateAdded, order: .reverse)])
            return try modelContext.fetch(descriptor)
        } catch  {
            print("Failed to fetch data from DB. \(error)")
            return []
        }
    }
}

// mock class
class MockStorageManager: StorageProtocol {
    private var cities: [CityModel] = []
    
    init() {
        cities = [
            CityModel(name: "Kyiv", longitude: 50.0, latitude: 30.0),
            CityModel(name: "Warsaw", longitude: 45.0, latitude: 25.0)
        ]
    }
    
    func addCity(name: String, longitude: Double, latitude: Double) {
        let city = CityModel(name: name, longitude: longitude, latitude: latitude)
        cities.append(city)
    }
    
    func deleteCity(at indexSet: IndexSet) {
        for index in indexSet {
            cities.remove(at: index)
        }
    }
    
    func fetchCitiesFromDB() -> [CityModel] {
        return cities
    }
}

