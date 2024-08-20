//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Vladyslav Dikhtiaruk on 20/08/2024.
//

import Foundation

import Foundation

struct WeatherModel: Decodable {
    let coord: Coord
    let weather: [WeatherInfo]
    let base: String
    let main: MainInfo
    let visibility: Int
    let wind: Wind
    let clouds: CloudsInfo
    let dt: Int
    let sys: Sys?
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }

    struct WeatherInfo: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct MainInfo: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }

    struct CloudsInfo: Decodable {
        let all: Int
    }

    struct Sys: Decodable {
        let type: Int?
        let id: Int?
        let country: String?
        let sunrise: Int?
        let sunset: Int?
    }

}
