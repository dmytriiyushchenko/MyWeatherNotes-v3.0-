//
//  Note.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var text: String
    let createdAt: Date
    var weather: Weather?
    
    init(id: UUID = UUID(), text: String, createdAt: Date = Date(), weather: Weather? = nil) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.weather = weather
    }
}

struct Weather: Codable {
    let temperature: Double
    let description: String
    let icon: String
    let cityName: String
    
    var temperatureString: String {
        String(format: "%.0f°C", temperature)
    }
    
    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}
