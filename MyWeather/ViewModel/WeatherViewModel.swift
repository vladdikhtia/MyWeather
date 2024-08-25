//
//  CombinedViewModel.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 25/08/2024.
//

import Foundation
import Combine


final class WeatherViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var weather: WeatherModel? = nil
    @Published var cities = [CityModel]()
    
    private let networkManager: WeatherNetworkProtocol
    private let storageManager: StorageProtocol
    
    init(networkManager: WeatherNetworkProtocol, storageManager: StorageProtocol) {
        self.networkManager = networkManager
        self.storageManager = storageManager
        fetchCitiesFromDB()
    }
    
    // network
    func fetchWeather(latitude: Double, longitude: Double) {
        networkManager.fetchWeatherData(latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Weather request completed")
                case .failure(let error):
                    print("Error occurred: \(error)")
                }
            } receiveValue: { [weak self] returnedWeather in
                print("Received weather data: \(returnedWeather)")
                self?.weather = returnedWeather
            }
            .store(in: &cancellables)
    }
    
    // database
    func addCityToDB(cityName: String, cityLongitude: Double, cityLatitude: Double){
        storageManager.addCity(name: cityName, longitude: cityLongitude, latitude: cityLatitude)
        fetchCitiesFromDB()
    }
    
    func fetchCitiesFromDB() {
        self.cities = storageManager.fetchCitiesFromDB()
    }
    
    func deleteCityFromDB(_ indexSet: IndexSet) {
        storageManager.deleteCity(at: indexSet)
        fetchCitiesFromDB()
    }
    
    
}
