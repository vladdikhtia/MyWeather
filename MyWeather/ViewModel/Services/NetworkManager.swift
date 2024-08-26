//
//  NetworkServiceManager.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 25/08/2024.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error>
}

class NetworkManager: NetworkProtocol {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private let apiKey: String
    
    
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error> {
            guard var urlComponents = URLComponents(string: baseURL) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: String(latitude)),
                URLQueryItem(name: "lon", value: String(longitude)),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]
            
            guard let url = urlComponents.url else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, response -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: WeatherModel.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    
}


class MockNetworkManager: NetworkProtocol {
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error> {
        let mockData = WeatherModel(
            coord: WeatherModel.Coord(lon: longitude, lat: latitude),
            weather: [WeatherModel.WeatherInfo(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            base: "stations",
            main: WeatherModel.MainInfo(
                temp: 25.5,
                feels_like: 27.0,
                temp_min: 22.0,
                temp_max: 28.0,
                pressure: 1012,
                humidity: 60,
                sea_level: nil,
                grnd_level: nil
            ),
            visibility: 10000,
            wind: WeatherModel.Wind(speed: 5.0, deg: 180, gust: 7.0),
            clouds: WeatherModel.CloudsInfo(all: 0),
            dt: 1625235623,
            sys: WeatherModel.Sys(type: nil, id: nil, country: "US", sunrise: 1625212800, sunset: 1625266440),
            timezone: -14400,
            id: 5128581,
            name: "New York",
            cod: 200
        )
        
        // it returns a Publisher that mach to WeatherModel object after a 1-second delay to simulate network latency
        return Just(mockData)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


