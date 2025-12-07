//
//  WeatherService.swift
//  MyWeatherNotes
//
//  Created by Dmytrii  on 07.12.2025.
//

import Foundation

class WeatherService {
    private let apiKey = "7cf9ebf58c1c2ef77f0cc685bb2016f5"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(completion: @escaping (Result<Weather, Error>) -> Void) {
        let urlString = "\(baseURL)?q=Kyiv&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weather = Weather(
                    temperature: weatherResponse.main.temp,
                    description: weatherResponse.weather.first?.description ?? "",
                    icon: weatherResponse.weather.first?.icon ?? "",
                    cityName: weatherResponse.name
                )
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
