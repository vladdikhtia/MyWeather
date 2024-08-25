//
//  NetworkServiceManager.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 25/08/2024.
//

import Foundation
import Combine

protocol WeatherNetworkProtocol {
    func fetchWeatherData(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, Error>
}

class NetworkServiceManager: WeatherNetworkProtocol {
    
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


