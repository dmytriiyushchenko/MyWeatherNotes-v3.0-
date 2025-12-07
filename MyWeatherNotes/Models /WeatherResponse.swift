//
//  WeatherResponse.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation

struct WeatherResponse: Codable {
    let main: MainWeather
    let weather: [WeatherDescription]
    let name: String
}

struct MainWeather: Codable {
    let temp: Double
}

struct WeatherDescription: Codable {
    let description: String
    let icon: String
}
